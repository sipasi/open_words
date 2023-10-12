import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/storage/in_memory_storage.dart';
import 'package:open_words/storage/word_group_storage.dart';

class InMemoryWordGroupStorage extends InMemoryStorage<WordGroup> implements WordGroupStorage {}
