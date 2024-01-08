import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/data/language_info.dart';
import 'package:open_words/data/metadata/word_metadata.dart';
import 'package:open_words/data/word/word.dart';
import 'package:open_words/service/clipboard_service.dart';
import 'package:open_words/service/metadata/metadata_service.dart';
import 'package:open_words/service/navigation/material_navigator.dart';
import 'package:open_words/service/result.dart';
import 'package:open_words/service/text_to_speech_service.dart';
import 'package:open_words/view/mvvm/view_model.dart';
import 'package:open_words/view/word/edit/word_edit_page.dart';

class WordDetailViewModel extends ViewModel {
  Word _word;
  WordMetadata? _metadata;

  final LanguageInfo _origin;
  final LanguageInfo _translation;

  final _metadataService = GetIt.I.get<MetadataService>();

  final String groupId;
  final int wordId;

  final UpdateState updateState;

  final TextToSpeechService textToSpeech;
  final ClipboardService clipboard;

  Word get word => _word;
  WordMetadata? get metadata => _metadata;

  LanguageInfo get origin => _origin;
  LanguageInfo get translation => _translation;

  WordDetailViewModel({
    required this.updateState,
    required this.groupId,
    required this.wordId,
    required Word word,
    required LanguageInfo origin,
    required LanguageInfo translation,
    WordMetadata? metadata,
  })  : _word = word,
        _origin = origin,
        _translation = translation,
        _metadata = metadata,
        textToSpeech = GetIt.I.get<TextToSpeechService>(),
        clipboard = GetIt.I.get<ClipboardService>();

  @override
  Future load() async {
    _metadata = await _metadataService.localOrWeb(word.origin);
  }

  void delete(BuildContext context) {
    MaterialNavigator.popWith(
      context,
      CrudResult.delete(word),
    );
  }

  Future edit(BuildContext context) async {
    final result = await MaterialNavigator.push(
      context,
      (context) => WordEditPage(groupId: groupId, wordId: wordId, word: word, metadata: _metadata),
    );

    result.modified<(Word, WordMetadata)>((value) async {
      final word = value.$1;
      final metadata = value.$2;

      updateState(() {
        _word = word;
        _metadata = metadata;
      });
    });
  }
}
