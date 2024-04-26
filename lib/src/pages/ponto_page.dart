import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/configuration/app_layout_defaults.dart';

import 'package:flutter_app_bate_ponto/src/model/registro_ponto_snapshot.dart';
import 'package:flutter_app_bate_ponto/src/services/api_request_service.dart';
import 'package:flutter_app_bate_ponto/src/widgets/button/espelho_ponto_button.dart';
import 'package:flutter_app_bate_ponto/src/widgets/button/toggle_button.dart';
import 'package:flutter_app_bate_ponto/src/widgets/cards/horas_extras_card.dart';
import 'package:flutter_app_bate_ponto/src/widgets/cards/horas_trabalhadas_snapshot_card.dart';

class PontoPage extends StatefulWidget {
  const PontoPage({Key? key}) : super(key: key);

  @override
  State<PontoPage> createState() => _PontoPageState();
}

class _PontoPageState extends State<PontoPage> {
  late Future<RegistroPontoAtualSnapshot> _registroPontoSnapshot;
  final ApiRequestService _apiRequestService = ApiRequestService();

  @override
  void initState() {
    super.initState();
    _fetchRegistroPontoAtualSnapshot();
  }

  void _fetchRegistroPontoAtualSnapshot() {
    _registroPontoSnapshot =
        _apiRequestService.fetchRegistroPontoAtualSnapshot();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<RegistroPontoAtualSnapshot>(
      future: _registroPontoSnapshot,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.error_outline,
                  color: AppLayoutDefaults.errorColor,
                  size: 50.0,
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Erro: falha ao carregar informações de ponto.',
                    style: TextStyle(
                      color: AppLayoutDefaults.errorColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          final registroPontoSnapshot = snapshot.data!;
          return Column(
            children: [
              const Spacer(flex: 1),
              CustomToggleButtons(),
              HorasTrabalhadasCard(
                registroPontoSnapshot: registroPontoSnapshot,
              ),
              HorasExtrasCard(
                registroPontoSnapshot: registroPontoSnapshot,
              ),
              // ResumoMesCard(
              //   registroPontoSnapshot: registroPontoSnapshot,
              // ),
              const Spacer(flex: 9),
              const EspelhoPontoButton(),
            ],
          );
        }
      },
    );
  }
}
