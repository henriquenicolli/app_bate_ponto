import 'package:flutter/material.dart';

import '../text/entradas_saidas_text.dart';
import '../text/horas_extras_text.dart';

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
        child: Column(
          children: [
            HorasExtrasText(),
            EntradasSaidasText(
              text1: '02:00 horas',
            ),
          ],
        ),
      ),
    );
  }
}
