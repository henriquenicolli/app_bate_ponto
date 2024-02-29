import 'package:flutter/material.dart';

import '../text/entradas_saidas_text.dart';
import '../text/horas_extras_text.dart';

class HorasExtrassCard extends StatelessWidget {
  const HorasExtrassCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      margin: EdgeInsets.all(18.0),
      child: Column(
        children: [
          HorasExtrasText(),
          EntradasSaidasText(
            text1: '02:00 horas',
          ),
        ],
      ),
    );
  }
}
