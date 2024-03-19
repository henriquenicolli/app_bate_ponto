import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/model/registro_ponto_atual_snapshot.dart';

class ResumoMesCard extends StatefulWidget {
  RegistroPontoAtualSnapshot registroPontoSnapshot;

  ResumoMesCard({super.key, required this.registroPontoSnapshot});

  @override
  State<ResumoMesCard> createState() => _ResumoMesCardState();
}

class _ResumoMesCardState extends State<ResumoMesCard> {
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
