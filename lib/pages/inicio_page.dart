import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/widgets/welcome_widget.dart';

class InicioPage extends StatelessWidget {
  const InicioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Column(
        children: [
          WelcomeWidget(),
        ],
      ),
    );
  }
}
