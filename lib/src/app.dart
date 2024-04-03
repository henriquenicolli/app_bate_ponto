import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/pages/login_page.dart';
import 'package:flutter/services.dart';

class AppBarApp extends StatelessWidget {
  const AppBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue, // Define a cor padrão para azul
      ),
      home: const LoginPage(),
    );
  }
}
