import 'package:open_words/data/word/word_group.dart';

import 'json_parcer.dart';
import 'word_group_json_parcer.dart';

abstract class ImportExportJson {
  static JsonParcer<List<WordGroup>> group = WordGroupJsonParcer();
}
