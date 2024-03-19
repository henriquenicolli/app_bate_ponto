import 'package:location/location.dart';

import '../configuration/api_config_defaults.dart';
import '../model/enums/tipo_registro.dart';
import '../model/registro_ponto.dart';
import '../model/registro_ponto_snapshot.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiRequestService {
  Future<RegistroPontoAtualSnapshot> fetchRegistroPontoAtualSnapshot() async {
    final response =
        await http.get(Uri.parse(ApiConfig.getRegistroPontoSnapshot));

    if (response.statusCode == 200) {
      return RegistroPontoAtualSnapshot.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load registros de ponto');
    }
  }

  Future<List<RegistroPonto>> fetchRegistroPontoMesList(
      String mesRegistros) async {
    final response = await http
        .get(Uri.parse('${ApiConfig.getRegistroPontoMes}$mesRegistros'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((json) => RegistroPonto.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load registros de ponto');
    }
  }

  Future<int> postRegistraPonto(
      LocationData currentLocation, TipoRegistro tipoRegistro) async {
    final String dataHoraRegistroPonto = DateTime.now().toIso8601String();

    http.Response response = await http.post(
      Uri.parse(ApiConfig.postRegistrarPontoPath),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'dataHoraRegistroPonto': dataHoraRegistroPonto,
        'latitude': currentLocation.latitude.toString(),
        'longitude': currentLocation.longitude.toString(),
        'tipoRegistro': tipoRegistro.toString().split('.').last
      }),
    );

    return response.statusCode;
  }
}
