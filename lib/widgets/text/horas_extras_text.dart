import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/configuration/app_colors.dart';

class HorasExtrasText extends StatelessWidget {
  const HorasExtrasText({
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
