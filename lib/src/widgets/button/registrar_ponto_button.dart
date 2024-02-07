import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/configuration/app_layout_defaults.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegistrarPontoButton extends StatelessWidget {
  const RegistrarPontoButton({super.key});

  Future<http.Response> registraPonto(BuildContext context) async {
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
      // Exibir Snackbar de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ponto registrado com sucesso'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      // Exibir Snackbar de erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro durante registro de ponto'),
          backgroundColor: Colors.red,
        ),
      );
    }

    return response;
  }

  Future<void> _registrarPontoDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
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
                Navigator.pop(context, 'Cancel'),
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => {
                registraPonto(context),
                Navigator.pop(context, 'OK'),
              },
              child: const Text('Registrar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 70,
      child: ElevatedButton(
        onPressed: () {
          _registrarPontoDialog(context);
        },
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
      ),
    );
  }
}
