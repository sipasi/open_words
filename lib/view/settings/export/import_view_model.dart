import 'package:open_words/view/mvvm/view_model.dart';
import 'package:open_words/storage/word_group_storage.dart';

class ImportViewModel extends ViewModel {
  final WordGroupStorage _storage;

  ImportViewModel(this._storage);
}
