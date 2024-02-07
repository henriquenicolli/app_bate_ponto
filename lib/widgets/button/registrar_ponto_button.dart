import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/configuration/app_colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegistrarPontoButton extends StatelessWidget {
  const RegistrarPontoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 70,
      child: ElevatedButton(
        onPressed: () {
          // Ação a ser executada ao pressionar o botão
          registraPonto();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondaryColor,
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

  Future<http.Response> registraPonto() {
    final String dataHoraRegistroPonto = DateTime.now().toIso8601String();

    return http.post(
      Uri.parse('http://localhost:10000/v1/bateponto/registrar'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'dataHoraRegistroPonto': dataHoraRegistroPonto,
      }),
    );
  }
}
