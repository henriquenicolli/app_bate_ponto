import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/configuration/app_layout_defaults.dart';

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
            color: AppLayoutDefaults.secondaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            fontFamily: AppLayoutDefaults.fontFamily),
      ),
    );
  }
}
