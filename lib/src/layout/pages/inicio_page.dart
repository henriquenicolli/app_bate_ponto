import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/layout/widgets/button/registrar_ponto_button.dart';
import 'package:flutter_app_bate_ponto/src/model/enums/tipo_marcacao.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/api_request_service.dart';
import '../../services/internet_connectivity_service.dart';
import '../widgets/text/welcome_text.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({Key? key}) : super(key: key);

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {

  void _reenviaPonto() async {
    if (InternetConnectivityService.instance.hasInternetConnection) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> registrosPonto = prefs.getStringList('registrosPonto') ?? [];

      for (String registroPonto in registrosPonto) {
        Map<String, dynamic> registroPontoDeserializado = jsonDecode(registroPonto);

        String? dataMarcacaoPonto = registroPontoDeserializado['dataMarcacaoPonto'];
        String? horaMarcacaoPonto = registroPontoDeserializado['horaMarcacaoPonto'];
        double? latitude = registroPontoDeserializado['latitude'];
        double? longitude = registroPontoDeserializado['longitude'];
        String? tipoMarcacao = registroPontoDeserializado['tipoMarcacao'];

        if (dataMarcacaoPonto != null && horaMarcacaoPonto != null && latitude != null && longitude != null && tipoMarcacao != null) {
          // Aqui você pode fazer a requisição com os dados recuperados
          // Após a requisição bem-sucedida, remova os dados de SharedPreferences
          try {

            int? response = await ApiRequestService().postRegistraPonto(
                dataMarcacaoPonto,
                horaMarcacaoPonto,
                currentLocation,
                TipoMarcacao.fromString(tipoMarcacao),
                fusoHorarioMarcacao,
                true,
                "123.456.789-00",
                "Inicio de expediente",
                1,
                "O",
                "576475e7-e365-4d71-be93-f8182866e102",
                false,
                false
            );

            if (response == 200 || response == 202) {
              print("sucesso ao sincronizar registro de ponto" + registroPontoDeserializado.toString());
              await prefs.remove('registrosPonto');
            }
          } catch (exc) {
            print('Erro ao reenviar registro de ponto.' + exc.toString());
          }
        }
      }
    }
  }


  @override
  void initState() {
    super.initState();

    if (InternetConnectivityService.instance.hasInternetConnection) {
      _reenviaPonto();
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Column(
        children: [
          WelcomeWidget(),
          RegistrarPontoButton(),
          Padding(
            padding: EdgeInsets.all(32),
            child: Text(
              'Quadro de avisos',
              softWrap: true,
            ),
          )
        ],
      ),
    );
  }
}