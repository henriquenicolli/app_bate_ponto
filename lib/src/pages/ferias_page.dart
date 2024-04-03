import 'package:flutter/material.dart';

class FeriasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Férias'),
      ),
      body: Center(
        child: Text(
          'Conteúdo da página de férias',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
