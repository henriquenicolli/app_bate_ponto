import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/configuration/app_layout_defaults.dart';
import 'package:flutter_app_bate_ponto/src/model/registro_ponto.dart';
import 'package:flutter_app_bate_ponto/src/utils/DateUtils.dart';
import 'package:flutter_app_bate_ponto/src/widgets/selector/mes_selector_state.dart';
import '../widgets/listview/espelho_ponto_list_view.dart';
import 'package:http/http.dart' as http;

class EspelhoPontoPage extends StatefulWidget {
  const EspelhoPontoPage({super.key});

  @override
  State<EspelhoPontoPage> createState() => _EspelhoPontoPageState();
}

class _EspelhoPontoPageState extends State<EspelhoPontoPage> {
  late Future<List<RegistroPonto>> registroPontoList;
  String? _mesSelecionado;

  @override
  void initState() {
    super.initState();
    _mesSelecionado = getMonthName(DateTime.now().month);
    registroPontoList = getRegistrosPontoList(_mesSelecionado!);
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

Future<List<RegistroPonto>> getRegistrosPontoList(String mesRegistros) async {
  final response = await http.get(
      Uri.parse('http://localhost:10000/v1/bateponto/registros/$mesRegistros'));

  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    return jsonResponse.map((json) => RegistroPonto.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load registros de ponto');
  }
}
