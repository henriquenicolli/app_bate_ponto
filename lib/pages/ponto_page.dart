import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/widgets/espelho_ponto_button.dart';
import 'package:flutter_app_bate_ponto/widgets/horas_extras_painel.dart';
import 'package:flutter_app_bate_ponto/widgets/horas_trabalhadas_painel.dart';
import 'package:flutter_app_bate_ponto/widgets/toggle_button.dart';

class PontoPage extends StatefulWidget {
  const PontoPage({super.key});

  @override
  State<PontoPage> createState() => _PontoPageState();
}

class _PontoPageState extends State<PontoPage> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        //PontoEletronicoText(),
        CustomToggleButtons(),
        Spacer(flex: 1),
        HorasTrabalhadasPainel(),
        Spacer(flex: 1),
        HorasExtrassPainel(),
        Spacer(flex: 5),
        EspelhoPontoButton(),
        Spacer(flex: 18),
      ],
    );
  }
}
