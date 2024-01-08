import 'package:flutter/material.dart';
import 'package:open_words/collection/readonly_list.dart';
import 'package:open_words/view/mvvm/view_model.dart';
import 'package:open_words/service/navigation/material_navigator.dart';
import 'package:open_words/storage/word_group_storage.dart';
import 'package:open_words/view/settings/export/option/export_options_page.dart';
import 'package:open_words/view/shared/scaffold/selectable_words_view_model.dart';

class ExportViewModel extends ViewModel {
  final WordGroupStorage _storage;

  late final SelectableWordsViewModel selectable;

  ExportViewModel(this._storage);

  @override
  Future load() async {
    final all = await _storage.getAll();

    selectable = SelectableWordsViewModel(all.asReadonly());
  }

  Future toExportDestination(BuildContext context) {
    return MaterialNavigator.push(context, (context) => ExportOptionsPage(groups: selectable.getSelected()));
  }

  bool canShare() {
    return selectable.isNotEmpty;
  }
}
