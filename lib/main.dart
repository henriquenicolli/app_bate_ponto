import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/widgets/navigation_bar_widget.dart';

void main() {
  runApp(const AppBarApp());
}

class AppBarApp extends StatelessWidget {
  const AppBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CustomNavigationBar(),
    );
  }
}
