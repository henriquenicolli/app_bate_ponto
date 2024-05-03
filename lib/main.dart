import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/app.dart';
import 'package:windows_plugin/windows_plugin.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  WindowsPlugin().getPlatformVersion().then((String? version) {
    print(version);
  });

  runApp(const AppBarApp());
}
