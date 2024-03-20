import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/model/registro_ponto_snapshot.dart';

class ResumoMesCard extends StatelessWidget {
  final RegistroPontoAtualSnapshot registroPontoSnapshot;

  const ResumoMesCard({
    Key? key,
    required this.registroPontoSnapshot,
  }) : super(key: key);

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
              "Resumo do mês",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Horas trabalhadas:",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  "${registroPontoSnapshot.horasTrabalhadasHoje}",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Horas compensáveis:",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  "${registroPontoSnapshot.horasCompensaveisMes}",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
