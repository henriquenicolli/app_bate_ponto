import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/configuration/app_layout_defaults.dart';
import 'package:flutter_app_bate_ponto/src/model/registro_ponto_snapshot.dart';
import 'package:flutter_app_bate_ponto/src/widgets/button/toggle_button.dart';

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Horas Trabalhadas",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            HorasTrabalhadas(),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(flex: 5),
                    Text(
                      'ENTRADAS',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Spacer(flex: 5),
                    Text(
                      'SAÍDAS',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Spacer(flex: 5),
                  ],
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount:
                  (registroPontoSnapshot.registroPontoHojeList.length / 2)
                      .ceil(),
              itemBuilder: (context, index) {
                int entradaIndex = index * 2;
                int saidaIndex = entradaIndex + 1;

                String textoEntrada = registroPontoSnapshot
                            .registroPontoHojeList[entradaIndex].tipoRegistro ==
                        "ENTRADA"
                    ? registroPontoSnapshot
                        .registroPontoHojeList[entradaIndex].horaFormatada
                    : "";

                String textoSaida = saidaIndex <
                            registroPontoSnapshot
                                .registroPontoHojeList.length &&
                        registroPontoSnapshot.registroPontoHojeList[saidaIndex]
                                .tipoRegistro ==
                            "SAIDA"
                    ? registroPontoSnapshot
                        .registroPontoHojeList[saidaIndex].horaFormatada
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
  const HorasTrabalhadas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        '08:00 horas trabalhadas',
        style: TextStyle(
          color: Colors.blue, // Exemplo de cor, substitua pela cor desejada
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
            Spacer(flex: 5),
            Text(
              text1,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            Spacer(flex: 5),
            Text(
              text2,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            Spacer(flex: 5),
          ],
        ),
      ),
    );
  }
}
