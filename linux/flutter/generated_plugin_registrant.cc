//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <file_selector_linux/file_selector_plugin.h>
#include <flutter_localization/flutter_localization_plugin.h>
#include <modal_progress_hud_nsn/modal_progress_hud_nsn_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) file_selector_linux_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "FileSelectorPlugin");
  file_selector_plugin_register_with_registrar(file_selector_linux_registrar);
  g_autoptr(FlPluginRegistrar) flutter_localization_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "FlutterLocalizationPlugin");
  flutter_localization_plugin_register_with_registrar(flutter_localization_registrar);
  g_autoptr(FlPluginRegistrar) modal_progress_hud_nsn_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "ModalProgressHudNsnPlugin");
  modal_progress_hud_nsn_plugin_register_with_registrar(modal_progress_hud_nsn_registrar);
}
