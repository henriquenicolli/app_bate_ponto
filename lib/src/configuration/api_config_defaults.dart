class ApiConfig {
  static const String _basePath = 'https://api.example.com/';
  static const String _testPath = 'http://localhost:10000/';
  static bool isTestMode = true;

  static const String _registrarPontoPathPOST = 'v1/rep/registroPonto/salvar';
  static const String _registroPontoSnapshotGET =
      'v1/rep/registroPonto/snapshot';
  static const String _registrosPontoMesGET = 'v1/rep/registroPonto/';

  static String get _apiUrl {
    if (isTestMode) {
      return _testPath;
    } else {
      return _basePath;
    }
  }

  static String get postRegistrarPontoPath {
    return _apiUrl + _registrarPontoPathPOST;
  }

  static String get getRegistroPontoSnapshot {
    return _apiUrl + _registroPontoSnapshotGET;
  }

  static String get getRegistroPontoMes {
    return _apiUrl + _registrosPontoMesGET;
  }
}
