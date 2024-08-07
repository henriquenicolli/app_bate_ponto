import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/configuration/app_layout_defaults.dart';

import '../../pages/espelho_ponto_page.dart';

class IncluirRegistroButton extends StatelessWidget {
  const IncluirRegistroButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(18.0),
      child: SizedBox(
        width: 300,
        height: 70,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EspelhoPontoPage()),
            );
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
            'Incluir Registro',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
