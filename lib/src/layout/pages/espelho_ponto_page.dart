import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/configuration/app_layout_defaults.dart';
import 'package:flutter_app_bate_ponto/src/model/registro_ponto.dart';
import 'package:flutter_app_bate_ponto/src/services/api_request_service.dart';
import 'package:flutter_app_bate_ponto/src/utils/date_utils.dart';

import 'package:flutter_app_bate_ponto/src/layout/widgets/selector/mes_selector_state.dart';
import '../widgets/button/incluir_registro_button.dart';
import '../widgets/listview/espelho_ponto_list_view.dart';

class EspelhoPontoPage extends StatefulWidget {
  const EspelhoPontoPage({Key? key}) : super(key: key);

  @override
  State<EspelhoPontoPage> createState() => _EspelhoPontoPageState();
}

class _EspelhoPontoPageState extends State<EspelhoPontoPage> {
  late Future<List<RegistroPonto>> _registroPontoList;
  late String _mesSelecionado;
  final ApiRequestService _apiRequestService = ApiRequestService();

  @override
  void initState() {
    super.initState();
    _mesSelecionado = getMonthName(DateTime.now().month);
    _fetchRegistroPontoList();
  }

  void _fetchRegistroPontoList() {
    _registroPontoList = _apiRequestService.fetchRegistroPontoMesList(_mesSelecionado, '1');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Espelho de ponto',
          style: TextStyle(
            fontFamily: AppLayoutDefaults.fontFamily,
            fontWeight: FontWeight.bold,
            color: AppLayoutDefaults.secondaryColor,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(
                Icons.notification_important,
                color: AppLayoutDefaults.secondaryColor,
              ),
              onPressed: () => {}
            ),
          )
        ],
      ),
      body: Column(
        children: [
          MesSelector(
            onMesSelected: (value) {
              setState(() {
                _mesSelecionado = value;
                _fetchRegistroPontoList();
              });
            },
          ),
          Expanded(
            child: FutureBuilder<List<RegistroPonto>>(
              future: _registroPontoList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return EspelhoPontoListView(items: snapshot.data!);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
          IncluirRegistroButton(),
        ],
      ),
    );
  }
}
