import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/model/registro_ponto_snapshot.dart';

class HorasExtrasCard extends StatefulWidget {
  final RegistroPontoAtualSnapshot registroPontoSnapshot;

  const HorasExtrasCard({
    Key? key,
    required this.registroPontoSnapshot,
  }) : super(key: key);

  @override
  State<HorasExtrasCard> createState() => _HorasExtrasCardState();
}

class _HorasExtrasCardState extends State<HorasExtrasCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(18.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Horas Extras",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Horas extras realizadas:",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              "${widget.registroPontoSnapshot.formattedCompensaveisMes}",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
