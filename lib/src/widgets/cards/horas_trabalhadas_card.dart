import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/configuration/app_layout_defaults.dart';
import 'package:flutter_app_bate_ponto/src/model/registro_ponto_snapshot.dart';
import 'package:flutter_app_bate_ponto/src/widgets/button/toggle_button.dart';

class HorasTrabalhadasCard extends StatefulWidget {
  final RegistroPontoAtualSnapshot registroPontoSnapshot;

  const HorasTrabalhadasCard({Key? key, required this.registroPontoSnapshot})
      : super(key: key);

  @override
  State<HorasTrabalhadasCard> createState() => _HorasTrabalhadasCardState();
}

class _HorasTrabalhadasCardState extends State<HorasTrabalhadasCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          CustomToggleButtons(),
          HorasTrabalhadas(),
          const Padding(
            padding: EdgeInsets.all(5.0),
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(flex: 5),
                  Text(
                    'ENTRADAS',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      fontFamily: AppLayoutDefaults.fontFamily,
                    ),
                  ),
                  Spacer(flex: 5),
                  Text(
                    'SAIDAS',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      fontFamily: AppLayoutDefaults.fontFamily,
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
                (widget.registroPontoSnapshot.registroPontoHojeList.length / 2)
                    .ceil(),
            itemBuilder: (context, index) {
              int entradaIndex = index * 2;
              int saidaIndex = entradaIndex + 1;

              String textoEntrada = widget.registroPontoSnapshot
                          .registroPontoHojeList[entradaIndex].tipoRegistro ==
                      "ENTRADA"
                  ? widget.registroPontoSnapshot
                      .registroPontoHojeList[entradaIndex].horaFormatada
                  : "";

              String textoSaida = saidaIndex <
                          widget.registroPontoSnapshot.registroPontoHojeList
                              .length &&
                      widget.registroPontoSnapshot
                              .registroPontoHojeList[saidaIndex].tipoRegistro ==
                          "SAIDA"
                  ? widget.registroPontoSnapshot
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
          color: AppLayoutDefaults.secondaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 18,
          fontFamily: AppLayoutDefaults.fontFamily,
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
                fontFamily: AppLayoutDefaults.fontFamily,
              ),
            ),
            const Spacer(flex: 5),
            Text(
              text2,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                fontFamily: AppLayoutDefaults.fontFamily,
              ),
            ),
            const Spacer(flex: 5),
          ],
        ),
      ),
    );
  }
}
