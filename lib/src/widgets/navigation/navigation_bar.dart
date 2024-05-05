import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/configuration/app_layout_defaults.dart';
import 'package:flutter_app_bate_ponto/src/pages/inicio_page.dart';
import 'package:flutter_app_bate_ponto/src/pages/ponto_page.dart';
import 'package:flutter_app_bate_ponto/src/widgets/third_party/adaptive_scaffold.dart';

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

  _mostrarInformacoes() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Informações'),
          content: const Text('building...'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o Dialog
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
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
                Icons.info,
                color: AppLayoutDefaults.secondaryColor,
              ),
              onPressed: () => _mostrarInformacoes(),
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
        });
  }
}
