import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/configuration/app_layout_defaults.dart';

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
              color: AppLayoutDefaults.secondaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 30,
              fontFamily: AppLayoutDefaults.fontFamily),
        ),
      ),
    );
  }
}
