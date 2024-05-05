import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/model/registro_ponto_snapshot.dart';

class HorasTrabalhadasCard extends StatelessWidget {
  final RegistroPontoAtualSnapshot registroPontoSnapshot;

  const HorasTrabalhadasCard({
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 8),
            HorasTrabalhadas(registroPontoSnapshot: registroPontoSnapshot),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ENTRADAS',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    'SAÍDAS',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount:
                  (registroPontoSnapshot.registroPontoSelecionadoList.length / 2)
                      .ceil(),
              itemBuilder: (context, index) {
                int entradaIndex = index * 2;
                int saidaIndex = entradaIndex + 1;

                String textoEntrada = registroPontoSnapshot
                            .registroPontoSelecionadoList[entradaIndex].tipoMarcacao ==
                        "E"
                    ? registroPontoSnapshot
                        .registroPontoSelecionadoList[entradaIndex].horaFormatada
                    : "";

                String textoSaida = saidaIndex <
                            registroPontoSnapshot
                                .registroPontoSelecionadoList.length &&
                        registroPontoSnapshot.registroPontoSelecionadoList[saidaIndex]
                                .tipoMarcacao ==
                            "S"
                    ? registroPontoSnapshot
                        .registroPontoSelecionadoList[saidaIndex].horaFormatada
                    : "";

                return EntradasSaidasText(
                  text1: textoEntrada,
                  text2: textoSaida,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class HorasTrabalhadas extends StatelessWidget {
  final RegistroPontoAtualSnapshot registroPontoSnapshot;

  const HorasTrabalhadas({Key? key, required this.registroPontoSnapshot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        '${registroPontoSnapshot.formattedHorasTrabalhadas} horas trabalhadas',
        style: const TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}

class EntradasSaidasText extends StatelessWidget {
  final String text1;
  final String text2;

  const EntradasSaidasText({
    Key? key,
    required this.text1,
    required this.text2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 5),
            Text(
              text1,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const Spacer(flex: 5),
            Text(
              text2,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const Spacer(flex: 5),
          ],
        ),
      ),
    );
  }
}
