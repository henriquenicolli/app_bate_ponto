
import 'windows_plugin_platform_interface.dart';

class WindowsPlugin {
  Future<String?> getPlatformVersion() {
    return WindowsPluginPlatform.instance.getPlatformVersion();
  }
}
