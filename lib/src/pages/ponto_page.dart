import 'package:flutter/material.dart';

import 'package:flutter_app_bate_ponto/src/model/registro_ponto_snapshot.dart';
import 'package:flutter_app_bate_ponto/src/services/api_request_service.dart';
import 'package:flutter_app_bate_ponto/src/widgets/button/espelho_ponto_button.dart';
import 'package:flutter_app_bate_ponto/src/widgets/cards/horas_extras_card.dart';
import 'package:flutter_app_bate_ponto/src/widgets/cards/horas_trabalhadas_card.dart';
import 'package:flutter_app_bate_ponto/src/widgets/cards/resumo_mes_card.dart';

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
          return Center(child: Text('Erro: ${snapshot.error}'));
        } else {
          final registroPontoSnapshot = snapshot.data!;
          return Column(
            children: [
              const Spacer(flex: 1),
              HorasTrabalhadasCard(
                registroPontoSnapshot: registroPontoSnapshot,
              ),
              HorasExtrasCard(
                registroPontoSnapshot: registroPontoSnapshot,
              ),
              ResumoMesCard(
                registroPontoSnapshot: registroPontoSnapshot,
              ),
              const Spacer(flex: 9),
              const EspelhoPontoButton(),
            ],
          );
        }
      },
    );
  }
}
