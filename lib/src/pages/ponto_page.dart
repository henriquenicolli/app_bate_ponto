import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/widgets/button/espelho_ponto_button.dart';
import 'package:flutter_app_bate_ponto/src/widgets/painel/horas_extras_painel.dart';
import 'package:flutter_app_bate_ponto/src/widgets/painel/horas_trabalhadas_painel.dart';
import 'package:flutter_app_bate_ponto/src/widgets/button/toggle_button.dart';

class PontoPage extends StatelessWidget {
  const PontoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CustomToggleButtons(),
        Spacer(flex: 2),
        HorasTrabalhadasPainel(),
        Spacer(flex: 2),
        HorasExtrassPainel(),
        Spacer(flex: 2),
        EspelhoPontoButton(),
        Spacer(flex: 4),
      ],
    );
  }
}
