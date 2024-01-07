import 'package:open_words/collection/readonly_list.dart';
import 'package:open_words/data/metadata/word_metadata.dart';
import 'package:open_words/view/game/word_compare/helper_text.dart';
import 'package:open_words/view/game/word_compare/word_compare_tool.dart';

class HelperTextList {
  final List<HelperText> _cache = [];
  final List<HelperText> _requested = [];

  ReadonlyList<HelperText> get requested => ReadonlyList(_requested);

  int _count = 0;

  void fillFrom(WordMetadata? metadata) {
    _requested.clear();

    _cache.clear();
    _count = 0;

    if (metadata == null) {
      return;
    }

    _cache.addAll(WordCompareTool.helpersFrom(metadata));
  }

  bool canRequest() {
    return _count < _cache.length;
  }

  void request() {
    if (canRequest() == false) {
      return;
    }

    _requested.add(_cache[_count]);

    _count++;
  }

  void clear() {
    _cache.clear();
    _count = 0;
  }
}
