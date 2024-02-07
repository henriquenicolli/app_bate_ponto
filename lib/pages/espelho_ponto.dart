import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/configuration/app_colors.dart';
import 'package:flutter_app_bate_ponto/model/controle_ponto.dart';
import '../widgets/listview/espelho_ponto_list_view.dart';
import 'package:http/http.dart' as http;

class EspelhoPonto extends StatefulWidget {
  EspelhoPonto({super.key});

  @override
  State<EspelhoPonto> createState() => _EspelhoPontoState();
}

Future<List<ControlePonto>> getControlePonto() async {
  final response = await http
      .get(Uri.parse('http://localhost:10000/v1/bateponto/registros'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<dynamic> jsonResponse = json.decode(response.body);
    return jsonResponse.map((json) => ControlePonto.fromJson(json)).toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load registros de ponto');
  }
}

class _EspelhoPontoState extends State<EspelhoPonto> {
  late Future<List<ControlePonto>> items;

  @override
  void initState() {
    super.initState();
    items = getControlePonto();
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
              color: AppColors.secondaryColor,
            ),
          ),
          Text(
            'Espelho de ponto',
            style: TextStyle(
                fontFamily: 'NotoSans',
                fontWeight: FontWeight.bold,
                color: AppColors.secondaryColor),
          ),
        ])),
        body: FutureBuilder<List<ControlePonto>>(
          future: items,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return EspelhoPontoListView(items: snapshot.data!);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ));
  }
}
