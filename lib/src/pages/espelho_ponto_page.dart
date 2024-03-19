import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/configuration/app_layout_defaults.dart';
import 'package:flutter_app_bate_ponto/src/model/registro_ponto.dart';
import 'package:flutter_app_bate_ponto/src/services/api_request_service.dart';
import 'package:flutter_app_bate_ponto/src/utils/date_utils.dart';
import 'package:flutter_app_bate_ponto/src/widgets/selector/mes_selector_state.dart';
import '../widgets/listview/espelho_ponto_list_view.dart';

class EspelhoPontoPage extends StatefulWidget {
  const EspelhoPontoPage({super.key});

  @override
  State<EspelhoPontoPage> createState() => _EspelhoPontoPageState();
}

class _EspelhoPontoPageState extends State<EspelhoPontoPage> {
  late Future<List<RegistroPonto>> registroPontoList;
  String? _mesSelecionado;
  ApiRequestService apiRequestService = ApiRequestService();

  @override
  void initState() {
    super.initState();
    _mesSelecionado = getMonthName(DateTime.now().month);
    registroPontoList =
        apiRequestService.fetchRegistroPontoMesList(_mesSelecionado!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Row(children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.timelapse,
              color: AppLayoutDefaults.secondaryColor,
            ),
          ),
          Text(
            'Espelho de ponto',
            style: TextStyle(
                fontFamily: AppLayoutDefaults.fontFamily,
                fontWeight: FontWeight.bold,
                color: AppLayoutDefaults.secondaryColor),
          ),
        ])),
        body: Column(
          children: [
            MesSelector(
              onMesSelected: (value) {
                setState(() {
                  _mesSelecionado = value;
                  registroPontoList = apiRequestService
                      .fetchRegistroPontoMesList(_mesSelecionado!);
                });
              },
            ),
            Expanded(
              child: FutureBuilder<List<RegistroPonto>>(
                future: registroPontoList,
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
          ],
        ));
  }
}
