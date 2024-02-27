import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/widgets/button/espelho_ponto_button.dart';
import 'package:flutter_app_bate_ponto/src/widgets/painel/horas_extras_painel.dart';
import 'package:flutter_app_bate_ponto/src/widgets/painel/horas_trabalhadas_painel.dart';

class PontoPage extends StatelessWidget {
  const PontoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Spacer(flex: 1),
        HorasTrabalhadasPainel(),
        HorasExtrassPainel(),
        Spacer(flex: 9),
        EspelhoPontoButton(),
      ],
    );
  }
}
