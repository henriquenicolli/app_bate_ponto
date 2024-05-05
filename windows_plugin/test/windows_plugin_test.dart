import 'package:flutter_test/flutter_test.dart';
import 'package:windows_plugin/windows_plugin.dart';
import 'package:windows_plugin/windows_plugin_platform_interface.dart';
import 'package:windows_plugin/windows_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockWindowsPluginPlatform
    with MockPlatformInterfaceMixin
    implements WindowsPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final WindowsPluginPlatform initialPlatform = WindowsPluginPlatform.instance;

  test('$MethodChannelWindowsPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelWindowsPlugin>());
  });

  test('getPlatformVersion', () async {
    WindowsPlugin windowsPlugin = WindowsPlugin();
    MockWindowsPluginPlatform fakePlatform = MockWindowsPluginPlatform();
    WindowsPluginPlatform.instance = fakePlatform;

    expect(await windowsPlugin.getPlatformVersion(), '42');
  });
}
