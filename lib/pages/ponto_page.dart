import 'package:flutter/material.dart';

class PontoPage extends StatelessWidget {
  const PontoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Text('Ponto!'),
            ),
          ),
        ],
      ),
    );
  }
}
