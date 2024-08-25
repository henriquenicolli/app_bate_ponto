import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/configuration/app_layout_defaults.dart';
import 'package:location/location.dart';

import '../../../model/enums/tipo_marcacao.dart';
import '../dialog/incluir_registro_ponto_dialog.dart';

LocationData currentLocation = LocationData.fromMap({
  'latitude': -23.5505,
  'longitude': -46.6333,
});

TipoMarcacao? tipoMarcacao = TipoMarcacao.ENTRADA;
const String fusoHorarioMarcacao = "GMT-3";


///
/// Classe [IncluirRegistroButton], componente do botão IncluirRegistroButton que ao ser clicado exibe um dialogo
/// para permitir a inclusao de um registro de ponto
///
class IncluirRegistroButton extends StatelessWidget {
  const IncluirRegistroButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(18.0),
      child: SizedBox(
        width: 300,
        height: 70,
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return IncluirPontoCallDialog(parentContext: context);
              },
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppLayoutDefaults.secondaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            'Incluir Registro',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}



