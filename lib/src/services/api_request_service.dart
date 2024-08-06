import 'package:location/location.dart';

import '../configuration/api_config_defaults.dart';
import '../model/enums/tipo_registro.dart';
import '../model/registro_ponto.dart';
import '../model/registro_ponto_snapshot.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiRequestService {

  final String USERNAME = 'username';
  final String PASSWORD = 'password';
  final Dio _dio = Dio();
  String? _token;

  ///
  /// Metodo [ApiRequestService] construtor que adiciona um interceptor para adicionar token as requisicoes ao webserver.
  ///
  ApiRequestService() {
    _dio.interceptors.add(InterceptorsWrapper(
      onError: (DioError error, ErrorInterceptorHandler handler) async {
        if (_token == null || error.response?.statusCode == 401) {
          String? newToken = await _generateNewToken();

          RequestOptions requestOptions = error.response!.requestOptions;

          _token = newToken;
          requestOptions.headers["Authorization"] = "Bearer $newToken";

          _dio.fetch(requestOptions).then((e) {
            handler.resolve(e);
          }).catchError((e) {
            handler.reject(e);
          });
        } else {
          handler.next(error);
        }
      },
    ));
  }

  ///
  /// Metodo [login] que executa a autenticacao de um usuario.
  ///
  Future<int> login<T>(String username, String password) async {
    final response = await http.post(
      Uri.parse(ApiConfig.getNewToken),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        USERNAME: username,
        PASSWORD: password,
      }),
    );

    storeUserCredentials(username, password);

    return response.statusCode == 200 ? 200 : 401;
  }


  ///
  /// Método [_generateNewToken] retorna um novo token.
  ///
  Future<String> _generateNewToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString(USERNAME);
    String? password = prefs.getString(PASSWORD);

    final response = await http.post(
      Uri.parse(ApiConfig.getNewToken),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['token'];
    } else {
      return '';
    }
  }

  ///
  /// Metodo GET [fetchRegistroPontoAtualSnapshot] que recupera o snapshot do registro de ponto atual.
  ///
  Future<RegistroPontoAtualSnapshot> fetchRegistroPontoAtualSnapshot() async {
    _token = await _generateNewToken();

    final response = await _dio.get(
      ApiConfig.getRegistroPontoSnapshot,
      options: Options(headers: {'Authorization': 'Bearer $_token'}),
    );

    if (response.statusCode == 200) {
      return RegistroPontoAtualSnapshot.fromJson(response.data);
    } else {
      throw Exception('Failed to load registros de ponto');
    }
  }

  ///
  /// Metodo GET [fetchRegistroPontoMesList] que recupera os registors de ponto do mes.
  ///
  Future<List<RegistroPonto>> fetchRegistroPontoMesList(String mesRegistros, String idFuncionario) async {
    final Uri url =
    Uri.parse('${ApiConfig.getRegistroPontoMes}?mes_selecionado=$mesRegistros&id_funcionario=$idFuncionario');

    final response = await _dio.get(
      url.toString(),
      options: Options(headers: {'Authorization': 'Bearer $_token'}),
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = response.data;
      return jsonResponse.map((json) => RegistroPonto.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load registros de ponto');
    }
  }

  ///
  /// Metodo POST [postRegistraPonto] que cria um novo registro de ponto.
  ///
  Future<int?> postRegistraPonto(
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

    final response = await _dio.post(
      ApiConfig.postRegistrarPontoPath,
      options: Options(headers: {
        'Content-Type': 'application/json; charset=UTF-8' ,
        'Authorization': 'Bearer $_token'
      }),
      data: jsonEncode(<String, dynamic>{
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

  ///
  /// Metodo PATCH [atualizarRegistroPonto] atualiza um registro de ponto.
  ///
  Future<int?> atualizarRegistroPonto(RegistroPonto registroPonto) async {
    final String horaMarcacaoPonto =
        '${registroPonto.horaMarcacaoPonto.hour.toString().padLeft(2, '0')}:${registroPonto.horaMarcacaoPonto.minute.toString().padLeft(2, '0')}:00';

    final response = await _dio.patch(
      ApiConfig.patchAtualizarPontoPath,
      options: Options(headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $_token'
      }),
      data: jsonEncode(<String, dynamic>{
        'numeroSequencialRegistro': registroPonto.numSeqRegistro,
        'horaMarcacaoPonto': horaMarcacaoPonto,
        'tipoMarcacao': registroPonto.tipoMarcacao,
        'idEmpregado': registroPonto.empregado,
      }),
    );

    return response.statusCode;
  }

  ///
  /// Metodo [storeUserCredentials] que armazena as credenciais de usuario no SharedPreferences.
  ///
  void storeUserCredentials(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(USERNAME, username);
    await prefs.setString(PASSWORD, password);
  }
}
