import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/widgets/button/espelho_ponto_button.dart';
import 'package:flutter_app_bate_ponto/src/widgets/cards/horas_extras_card.dart';
import 'package:flutter_app_bate_ponto/src/widgets/cards/horas_trabalhadas_card.dart';
import 'package:flutter_app_bate_ponto/src/widgets/cards/resumo_mes_card.dart';

class PontoPage extends StatelessWidget {
  const PontoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Spacer(flex: 1),
        HorasTrabalhadasCard(),
        HorasExtrassCard(),
        ResumoMesCard(),
        Spacer(flex: 9),
        EspelhoPontoButton(),
      ],
    );
  }
}
