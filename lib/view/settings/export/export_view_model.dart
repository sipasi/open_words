import 'package:flutter/material.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/view/mvvm/view_model.dart';
import 'package:open_words/service/navigation/material_navigator.dart';
import 'package:open_words/storage/word_group_storage.dart';
import 'package:open_words/view/settings/export/option/export_options_page.dart';

class ExportViewModel extends ViewModel {
  final WordGroupStorage _storage;

  final List<WordGroup> _groups;

  final Set<int> _selections;

  bool get allSelected => _selections.length == count;

  int get count => _groups.length;

  ExportViewModel(this._storage)
      : _groups = [],
        _selections = {};

  @override
  Future load() async {
    final all = await _storage.getAll();

    _groups.addAll(all);
  }

  Future toExportDestination(BuildContext context) {
    return MaterialNavigator.push(context, (context) => ExportOptionsPage(groups: getSelected()));
  }

  List<WordGroup> getSelected() {
    final selected = _selections.map((index) => _groups[index]).toList();

    return selected;
  }

  bool canShare() {
    return _selections.isNotEmpty;
  }

  void onTileTap(UpdateState updateState, bool contains, int index) {
    updateState(() {
      if (contains) {
        _selections.remove(index);

        return;
      }
      _selections.add(index);
    });
  }

  void onSelectAll(UpdateState updateState) {
    updateState(() {
      if (allSelected) {
        _selections.clear();
        return;
      }

      _selections.clear();

      _selections.addAll(List.generate(count, (index) => index));
    });
  }

  bool selectedAt(int index) {
    return _selections.contains(index);
  }

  WordGroup groupAt(int index) {
    return _groups[index];
  }
}
