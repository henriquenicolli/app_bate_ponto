import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'windows_plugin_platform_interface.dart';

/// An implementation of [WindowsPluginPlatform] that uses method channels.
class MethodChannelWindowsPlugin extends WindowsPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('windows_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
