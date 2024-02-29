import 'package:flutter/material.dart';

class ResumoMesCard extends StatelessWidget {
  const ResumoMesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      margin: EdgeInsets.all(18.0),
      child: Column(
        children: [Text("Resumo do mes card"), Text("horas compensaveis")],
      ),
    );
  }
}
