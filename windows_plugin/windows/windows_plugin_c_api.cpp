#include "include/windows_plugin/windows_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "windows_plugin.h"

void WindowsPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  windows_plugin::WindowsPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
