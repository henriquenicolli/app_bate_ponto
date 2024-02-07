import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/configuration/app_layout_defaults.dart';

class HorasTrabalhadasPainel extends StatelessWidget {
  const HorasTrabalhadasPainel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.black26,
      decoration: BoxDecoration(
        // Adicione a borda usando a propriedade border
        border: Border.all(
          color: Colors.grey[300] ?? Colors.black12,
          width: 5.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: const SizedBox(
        width: 400.0,
        //height: 150.0,
        child: Column(
          children: [
            HorasTrabalhadas(),
            EntradasSaidasText(text1: 'entradas', text2: 'saidas'),
            EntradasSaidasText(text1: '09:00', text2: '12:00'),
            EntradasSaidasText(text1: '13:00', text2: '18:00'),
          ],
        ),
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
