#ifndef FLUTTER_PLUGIN_WINDOWS_PLUGIN_H_
#define FLUTTER_PLUGIN_WINDOWS_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace windows_plugin {

class WindowsPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  WindowsPlugin();

  virtual ~WindowsPlugin();

  // Disallow copy and assign.
  WindowsPlugin(const WindowsPlugin&) = delete;
  WindowsPlugin& operator=(const WindowsPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace windows_plugin

#endif  // FLUTTER_PLUGIN_WINDOWS_PLUGIN_H_
