import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/widgets/button/registrar_ponto_button.dart';
import 'package:flutter_app_bate_ponto/src/widgets/text/welcome_text.dart';

class InicioPage extends StatelessWidget {
  const InicioPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Column(
        children: [
          WelcomeWidget(),
          RegistrarPontoButton(),
          Padding(
            padding: EdgeInsets.all(32),
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
