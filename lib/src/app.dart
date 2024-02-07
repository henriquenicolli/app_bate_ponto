import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/widgets/navigation/navigation_bar.dart';
import 'package:flutter/services.dart';

class AppBarApp extends StatelessWidget {
  const AppBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return const MaterialApp(
      home: CustomNavigationBar(),
    );
  }
}
