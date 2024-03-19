import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/model/registro_ponto_atual_snapshot.dart';

import '../text/entradas_saidas_text.dart';
import '../text/horas_extras_text.dart';

class HorasExtrasCard extends StatefulWidget {
  RegistroPontoAtualSnapshot registroPontoSnapshot;

  HorasExtrasCard({super.key, required this.registroPontoSnapshot});

  @override
  State<HorasExtrasCard> createState() => _HorasExtrasCardState();
}

class _HorasExtrasCardState extends State<HorasExtrasCard> {
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
