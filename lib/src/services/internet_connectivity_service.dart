import 'package:connectivity/connectivity.dart';

///
/// [InternetConnectivityService] Checa se existe conexao de internet
/// *** talvez nao funcione bem para Windows
/// Example:
/// if (InternetConnectivityService.instance.hasInternetConnection) {
///   // Há conexão de rede
/// } else {
///   // Não há conexão de rede
/// }
///
class InternetConnectivityService {
  final Connectivity _connectivity = Connectivity();
  bool hasInternetConnection = true;

  InternetConnectivityService._privateConstructor() {
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        hasInternetConnection = false;
        print('Sem conexão de internet');
      } else {
        hasInternetConnection = true;
        print('Conexão de internet disponível');
      }
    });
  }

  static final InternetConnectivityService instance = InternetConnectivityService._privateConstructor();
}