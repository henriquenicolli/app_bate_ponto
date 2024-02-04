import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/configuration/app_colors.dart';

class HorasExtrassPainel extends StatelessWidget {
  const HorasExtrassPainel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.black26,
      decoration: BoxDecoration(
        // Adicione a borda usando a propriedade border
        border: Border.all(
          color: Colors.grey[300] ?? Colors.black12,
          width: 5.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: const SizedBox(
        width: 400.0,
        //height: 100.0,
        child: Column(
          children: [
            HorasExtras(),
            EntradasSaidasText(
              text1: '02:00 horas',
            ),
          ],
        ),
      ),
    );
  }
}

class HorasExtras extends StatelessWidget {
  const HorasExtras({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'horas extras diretas',
        style: TextStyle(
          color: AppColors.secondaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 18,
          fontFamily: 'NotoSans',
        ),
      ),
    );
  }
}

class EntradasSaidasText extends StatelessWidget {
  final String text1;

  const EntradasSaidasText({super.key, required this.text1});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          text1,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            fontFamily: 'NotoSans',
          ),
        ),
      ),
    );
  }
}
