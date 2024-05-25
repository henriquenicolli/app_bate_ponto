import 'package:location/location.dart';

import '../configuration/api_config_defaults.dart';
import '../model/enums/tipo_registro.dart';
import '../model/registro_ponto.dart';
import '../model/registro_ponto_snapshot.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiRequestService {
  Future<RegistroPontoAtualSnapshot> fetchRegistroPontoAtualSnapshot() async {
    final response = await http.get(Uri.parse(ApiConfig.getRegistroPontoSnapshot));

    if (response.statusCode == 200) {
      return RegistroPontoAtualSnapshot.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load registros de ponto');
    }
  }

  Future<List<RegistroPonto>> fetchRegistroPontoMesList(String mesRegistros, String idFuncionario) async {
    final Uri url =
        Uri.parse('${ApiConfig.getRegistroPontoMes}?mes_selecionado=$mesRegistros&id_funcionario=$idFuncionario');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((json) => RegistroPonto.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load registros de ponto');
    }
  }

  Future<int> postRegistraPonto(
      LocationData currentLocation,
      TipoRegistro tipoRegistro,
      String fusoHorarioMarcacao,
      bool marcacaoOnline,
      String cpfFuncionario,
      String motivoMarcacao,
      int coletorRegistro,
      String fonteMarcacao,
      String idEmpregado) async {
    final DateTime now = DateTime.now();
    final String dataMarcacaoPonto =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    final String horaMarcacaoPonto =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
    http.Response response = await http.post(
      Uri.parse(ApiConfig.postRegistrarPontoPath),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'dataMarcacaoPonto': dataMarcacaoPonto,
        'horaMarcacaoPonto': horaMarcacaoPonto,
        'fusoHorarioMarcacao': fusoHorarioMarcacao,
        'marcacaoOnline': marcacaoOnline,
        'cpfFuncionario': cpfFuncionario,
        'latitude': currentLocation.latitude,
        'longitude': currentLocation.longitude,
        'motivoMarcacao': motivoMarcacao,
        'coletorRegistro': coletorRegistro,
        'fonteMarcacao': fonteMarcacao,
        'idEmpregado': idEmpregado,
        'tipoMarcacao': tipoRegistro.toString().split('.').last
      }),
    );

    return response.statusCode;
  }

  Future<int> atualizarRegistroPonto(RegistroPonto registroPonto) async {
    final String horaMarcacaoPonto =
        '${registroPonto.horaMarcacaoPonto.hour.toString().padLeft(2, '0')}:${registroPonto.horaMarcacaoPonto.minute.toString().padLeft(2, '0')}:00';

    http.Response response = await http.patch(
      Uri.parse(ApiConfig.patchAtualizarPontoPath),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'User-Agent': 'insomnia/8.6.1',
      },
      body: jsonEncode(<String, dynamic>{
        'numeroSequencialRegistro': registroPonto.numSeqRegistro,
        //'dataMarcacaoPonto':  registroPonto.dataMarcacaoPonto,
        'horaMarcacaoPonto': horaMarcacaoPonto,
        'tipoMarcacao': registroPonto.tipoMarcacao,
        'idEmpregado': registroPonto.empregado,
      }),
    );

    return response.statusCode;
  }
}
