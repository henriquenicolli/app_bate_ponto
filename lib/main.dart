import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/app.dart';
import 'package:platform/platform.dart';

void main() {
  if (LocalPlatform().isWindows) {
    WidgetsFlutterBinding.ensureInitialized();
  }

  runApp(const AppBarApp());
}
