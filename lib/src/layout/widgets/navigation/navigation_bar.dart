import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/app.dart';
import 'package:flutter_app_bate_ponto/src/configuration/app_layout_defaults.dart';
import 'package:flutter_app_bate_ponto/src/layout/pages/inicio_page.dart';
import 'package:flutter_app_bate_ponto/src/layout/pages/ponto_page.dart';
import 'package:flutter_app_bate_ponto/src/layout/widgets/third_party/adaptive_scaffold.dart';
import 'package:shared_preferences/shared_preferences.dart';

///
/// Classe [CustomNavigationBar] que controla a navigation bar do aplicativo.
/// Controla o estado de navegar entre [InicioPage] e [PontoPage].
/// Tambem controla a topbar, contendo o botao de logou e o titulo da aplicacao
///
class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _AdaptativeNavigationBarState();
}

class _AdaptativeNavigationBarState extends State<CustomNavigationBar> {
  int currentPageIndex = 0;

  static Widget _pageAtIndex(int index) {
    if (index == 0) {
      return const InicioPage();
    }

    return const PontoPage();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: AdaptiveScaffold(
            title: const Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.timelapse,
                    color: AppLayoutDefaults.secondaryColor,
                  ),
                ),
                Text(
                  'Bate Ponto',
                  style: TextStyle(
                      fontFamily: AppLayoutDefaults.fontFamily,
                      fontWeight: FontWeight.bold,
                      color: AppLayoutDefaults.secondaryColor),
                ),
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: const Icon(
                    Icons.logout,
                    color: AppLayoutDefaults.secondaryColor,
                  ),
                  onPressed: () => mostrarLogoutDialog(),
                ),
              )
            ],
            currentIndex: currentPageIndex,
            destinations: const [
              AdaptiveScaffoldDestination(title: 'inicio', icon: Icons.home),
              AdaptiveScaffoldDestination(title: 'ponto', icon: Icons.access_time),
            ],
            body: _pageAtIndex(currentPageIndex),
            onNavigationIndexChange: (newIndex) {
              setState(() {
                currentPageIndex = newIndex;
              });
            }));
  }

  ///
  /// Metodo [mostrarLogoutDialog] exibe o dialog responsavel por executar a acao de logout.
  ///
  mostrarLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Deseja sair?'),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Deslogar'),
              onPressed: () {
                limparSharedPreferences();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => AppBarApp()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }

  ///
  /// Metodo [limparSharedPreferences] limpa todas as opcoes armazenadas no SharedPreferences.
  ///
  Future<void> limparSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
