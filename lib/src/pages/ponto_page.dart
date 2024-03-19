import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/model/registro_ponto_atual_snapshot.dart';
import 'package:flutter_app_bate_ponto/src/widgets/button/espelho_ponto_button.dart';
import 'package:flutter_app_bate_ponto/src/widgets/cards/horas_extras_card.dart';
import 'package:flutter_app_bate_ponto/src/widgets/cards/horas_trabalhadas_card.dart';
import 'package:flutter_app_bate_ponto/src/widgets/cards/resumo_mes_card.dart';
import 'package:http/http.dart' as http;

class PontoPage extends StatefulWidget {
  const PontoPage({super.key});

  @override
  State<PontoPage> createState() => _PontoPageState();
}

class _PontoPageState extends State<PontoPage> {
  late Future<RegistroPontoAtualSnapshot> _registroPontoSnapshot;

  @override
  void initState() {
    super.initState();
    _registroPontoSnapshot = fetchRegistroPontoAtualSnapshot();
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
                  registroPontoSnapshot: registroPontoSnapshot),
              HorasExtrasCard(registroPontoSnapshot: registroPontoSnapshot),
              ResumoMesCard(registroPontoSnapshot: registroPontoSnapshot),
              const Spacer(flex: 9),
              const EspelhoPontoButton(),
            ],
          );
        }
      },
    );
  }
}

Future<RegistroPontoAtualSnapshot> fetchRegistroPontoAtualSnapshot() async {
  final response = await http.get(Uri.parse(
      'http://localhost:10000/v1/bateponto/registros/atual/snapshot'));

  if (response.statusCode == 200) {
    return RegistroPontoAtualSnapshot.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load registros de ponto');
  }
}
