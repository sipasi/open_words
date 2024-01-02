import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/view/mvvm/view_model.dart';
import 'package:open_words/service/navigation/material_navigator.dart';
import 'package:open_words/view/settings/export/export_page.dart';
import 'package:open_words/view/settings/export/import_page.dart';

class SettingsViewModel extends ViewModel {
  Future toImport(BuildContext context) => MaterialNavigator.push(context, (context) => GetIt.I.get<ImportPage>());
  Future toExport(BuildContext context) => MaterialNavigator.push(context, (context) => GetIt.I.get<ExportPage>());

  void addPreinstalled() {}

  void deleteAll() {}
}
