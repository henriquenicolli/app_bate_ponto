import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/widgets/registrar_ponto_button.dart';
import 'package:flutter_app_bate_ponto/widgets/welcome_text.dart';

class InicioPage extends StatelessWidget {
  const InicioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Column(
        children: [
          WelcomeWidget(),
          RegistrarPontoButton(),
          Padding(
            padding: const EdgeInsets.all(32),
            child: Text(
              'Quadro de avisos',
              softWrap: true,
            ),
          )
        ],
      ),
    );
  }
}
