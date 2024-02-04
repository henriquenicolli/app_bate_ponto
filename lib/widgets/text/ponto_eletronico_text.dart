import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/configuration/app_colors.dart';

class PontoEletronicoText extends StatelessWidget {
  final String title;

  const PontoEletronicoText({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          title,
          style: const TextStyle(
            color: AppColors.secondaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 30,
            fontFamily: 'NotoSans',
          ),
        ),
      ),
    );
  }
}
