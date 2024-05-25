import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/configuration/app_layout_defaults.dart';

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
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, fontFamily: AppLayoutDefaults.fontFamily),
        ),
      ),
    );
  }
}
