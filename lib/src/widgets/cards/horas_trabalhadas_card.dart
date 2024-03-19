import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/configuration/app_layout_defaults.dart';
import 'package:flutter_app_bate_ponto/src/model/registro_ponto_atual_snapshot.dart';
import 'package:flutter_app_bate_ponto/src/widgets/button/toggle_button.dart';

class HorasTrabalhadasCard extends StatefulWidget {
  RegistroPontoAtualSnapshot registroPontoSnapshot;

  HorasTrabalhadasCard({super.key, required this.registroPontoSnapshot});

  @override
  State<HorasTrabalhadasCard> createState() => _HorasTrabalhadasCardState();
}

class _HorasTrabalhadasCardState extends State<HorasTrabalhadasCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(18.0),
      child: Column(
        children: [
          CustomToggleButtons(),
          HorasTrabalhadas(),
          EntradasSaidasText(text1: 'ENTRADAS', text2: 'SAIDAS'),
          ListView.builder(
            shrinkWrap: true,
            itemCount:
                (widget.registroPontoSnapshot.registroPontoHojeList.length / 2)
                    .ceil(),
            itemBuilder: (context, index) {
              int entradaIndex = index * 2;
              int saidaIndex = entradaIndex + 1;

              if (saidaIndex <
                  widget.registroPontoSnapshot.registroPontoHojeList.length) {
                String textoEntrada = widget.registroPontoSnapshot
                            .registroPontoHojeList[entradaIndex].tipoRegistro ==
                        "ENTRADA"
                    ? widget.registroPontoSnapshot
                        .registroPontoHojeList[entradaIndex].horaFormatada
                    : "";

                String textoSaida = widget.registroPontoSnapshot
                            .registroPontoHojeList[saidaIndex].tipoRegistro ==
                        "SAIDA"
                    ? widget.registroPontoSnapshot
                        .registroPontoHojeList[saidaIndex].horaFormatada
                    : "";

                return EntradasSaidasText(
                  text1: textoEntrada,
                  text2: textoSaida,
                );
              } else {
                // Último par de ENTRADA sem SAIDA
                String textoEntrada = widget.registroPontoSnapshot
                            .registroPontoHojeList[entradaIndex].tipoRegistro ==
                        "ENTRADA"
                    ? widget.registroPontoSnapshot
                        .registroPontoHojeList[entradaIndex].horaFormatada
                    : "";

                return EntradasSaidasText(
                  text1: textoEntrada,
                  text2: "",
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class HorasTrabalhadas extends StatelessWidget {
  const HorasTrabalhadas({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
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

  const EntradasSaidasText(
      {super.key, required this.text1, required this.text2});

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
                  fontFamily: AppLayoutDefaults.fontFamily),
            ),
            const Spacer(flex: 5),
            Text(
              text2,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  fontFamily: AppLayoutDefaults.fontFamily),
            ),
            const Spacer(flex: 5),
          ],
        ),
      ),
    );
  }
}
