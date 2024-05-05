import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'windows_plugin_method_channel.dart';

abstract class WindowsPluginPlatform extends PlatformInterface {
  /// Constructs a WindowsPluginPlatform.
  WindowsPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static WindowsPluginPlatform _instance = MethodChannelWindowsPlugin();

  /// The default instance of [WindowsPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelWindowsPlugin].
  static WindowsPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [WindowsPluginPlatform] when
  /// they register themselves.
  static set instance(WindowsPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
