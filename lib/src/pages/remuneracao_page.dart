import 'package:flutter/material.dart';

class RemuneracaoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Remuneração'),
      ),
      body: Center(
        child: Text(
          'Conteúdo da página de remuneração',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
