import 'package:open_words/collection/readonly_list.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/view/mvvm/view_model.dart';

class SelectableWordsViewModel {
  final Set<int> _selections;

  final IReadonlyList<WordGroup> groups;

  bool get allSelected => _selections.length == groups.length;

  bool get isNotEmpty => _selections.isNotEmpty;

  int get selections => _selections.length;

  SelectableWordsViewModel(this.groups) : _selections = {};

  List<WordGroup> getSelected() {
    final selected = _selections.map((index) => groups[index]).toList();

    return selected;
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

      _selections.addAll(List.generate(groups.length, (index) => index));
    });
  }

  bool selectedAt(int index) {
    return _selections.contains(index);
  }

  WordGroup groupAt(int index) {
    return groups[index];
  }
}
