import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/configuration/app_colors.dart';

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
          print('Botão pressionado!');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
              horizontal: 30, vertical: 10), // Espaçamento interno do botão
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
