import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/configuration/app_colors.dart';
import '../../pages/espelho_ponto.dart';

class EspelhoPontoButton extends StatelessWidget {
  const EspelhoPontoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 70,
      child: ElevatedButton(
        onPressed: () {
          // Ação a ser executada ao pressionar o botão
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EspelhoPonto()),
          );
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
          'Espelho de ponto',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
