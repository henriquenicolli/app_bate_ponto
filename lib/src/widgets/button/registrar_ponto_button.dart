import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/configuration/app_layout_defaults.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegistrarPontoButton extends StatelessWidget {
  const RegistrarPontoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(width: 300, height: 70, child: ApiCallDialog());
  }
}

class ApiCallDialog extends StatefulWidget {
  const ApiCallDialog({super.key});

  @override
  _ApiCallDialogState createState() => _ApiCallDialogState();
}

class _ApiCallDialogState extends State<ApiCallDialog> {
  Future<void> _registraPonto() async {
    try {
      final String dataHoraRegistroPonto = DateTime.now().toIso8601String();

      http.Response response = await http.post(
        Uri.parse('http://localhost:10000/v1/bateponto/registrar'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'dataHoraRegistroPonto': dataHoraRegistroPonto,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 202) {
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Ponto registrado com sucesso'),
              backgroundColor: Colors.green,
            ),
          );
        });
      } else {
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Erro durante registro de ponto'),
              backgroundColor: Colors.red,
            ),
          );
        });
      }
    } catch (exc) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erro durante registro de ponto'),
            backgroundColor: Colors.red,
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppLayoutDefaults.secondaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Text(
        'Registrar ponto',
        style: TextStyle(fontSize: 20),
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Registrar ponto'),
              content: const SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Deseja confirmar o registro de ponto?'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => {
                    Navigator.of(context).pop(),
                  },
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () => {
                    Navigator.of(context).pop(),
                    _registraPonto(),
                  },
                  child: const Text('Registrar'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
