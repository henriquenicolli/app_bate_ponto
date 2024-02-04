import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/widgets/horas_painel.dart';
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
        HorasPainel(),
        Spacer(flex: 18),
      ],
    );
  }
}
