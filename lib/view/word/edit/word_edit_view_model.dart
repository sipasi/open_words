import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/collection/readonly_list.dart';
import 'package:open_words/data/metadata/meaning.dart';
import 'package:open_words/data/metadata/phonetic.dart';
import 'package:open_words/data/metadata/word_metadata.dart';
import 'package:open_words/data/word/word.dart';
import 'package:open_words/service/navigation/material_navigator.dart';
import 'package:open_words/service/result.dart';
import 'package:open_words/storage/metadata_storage.dart';
import 'package:open_words/storage/word_group_storage.dart';
import 'package:open_words/view/mvvm/view_model.dart';
import 'package:open_words/view/shared/text/text_edit_view_model.dart';

import 'meaning_edit.dart';
import 'phonetic_edit.dart';

class WordEditViewModel {
  final int groupId;
  final int wordId;
  final String origin;
  final TextEditViewModel translation;

  final UpdateState updateState;

  final List<Phonetic> _phonetics;
  final List<Meaning> _meanings;

  final IReadonlyList<Phonetic> phonetics;
  final IReadonlyList<Meaning> meanings;

  WordEditViewModel({
    required this.updateState,
    required this.groupId,
    required this.wordId,
    required this.origin,
    required this.translation,
    required List<Phonetic> phonetics,
    required List<Meaning> meanings,
  })  : _phonetics = phonetics,
        _meanings = meanings,
        phonetics = phonetics.asReadonly(),
        meanings = meanings.asReadonly();

  void editTranslation() {
    TextEditViewModel.setErrorIfEmpty(translation, updateState);
  }

  Future createPhonetic(
    BuildContext context,
  ) async {
    final result = await PhoneticEdit.pageCreate(context);

    result.contained<Phonetic>((value) {
      updateState(() => _phonetics.add(value));
    });
  }

  Future createMeaning(BuildContext context) async {
    final result = await MeaningEdit.pageCreate(context);

    result.contained<Meaning>((value) {
      updateState(() => _meanings.add(value));
    });
  }

  void removePhoneticAt(int index) {
    updateState(() => _phonetics.removeAt(index));
  }

  void removeMeaningAt(int index) {
    updateState(() => _meanings.removeAt(index));
  }

  Future editPhoneticAt(int index, BuildContext context) async {
    final result = await PhoneticEdit.pageEdit(context, _phonetics[index]);

    result.modified<Phonetic>((value) {
      updateState(() => _phonetics[index] = value);
    });
  }

  Future editMeaningAt(int index, BuildContext context) async {
    final result = await MeaningEdit.pageEdit(context, _meanings[index]);

    result.modified<Meaning>((value) {
      updateState(() => _meanings[index] = value);
    });
  }

  Future save(BuildContext context) async {
    TextEditViewModel.setErrorIfEmpty(translation, updateState);

    if (translation.isEmptyOrWhiteSpace) {
      return;
    }

    Word word = Word(
      origin: origin,
      translation: translation.textTrim,
    );
    WordMetadata metadata = WordMetadata(
      word: word.origin,
      phonetics: _phonetics,
      meanings: _meanings,
    );

    final groupStorage = GetIt.I.get<WordGroupStorage>();
    final metadataStorage = GetIt.I.get<MetadataStorage>();

    final group = await groupStorage.getBy(groupId);

    group!.words[wordId] = word;

    await groupStorage.set(group);

    await metadataStorage.set(metadata);

    if (context.mounted) MaterialNavigator.popWith(context, CrudResult.modify((word, metadata)));
  }
}
