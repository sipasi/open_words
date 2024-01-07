import 'package:flutter/material.dart';
import 'package:open_words/collection/readonly_list.dart';
import 'package:open_words/data/metadata/definition.dart';
import 'package:open_words/data/metadata/meaning.dart';
import 'package:open_words/service/navigation/material_navigator.dart';
import 'package:open_words/service/result.dart';
import 'package:open_words/view/mvvm/view_model.dart';
import 'package:open_words/view/shared/text/text_edit_view_model.dart';

class MeaningEditViewModel extends ViewModel {
  final List<Definition> _definitions;

  final bool _isCreate;

  final UpdateState updateState;

  final IReadonlyList<Definition> definitions;

  final TextEditViewModel partOfSpeech;
  final TextEditViewModel synonyms;
  final TextEditViewModel antonyms;

  final TextEditViewModel definition;
  final TextEditViewModel example;

  MeaningEditViewModel({
    required List<Definition> definitions,
    required this.updateState,
    required this.partOfSpeech,
    required this.synonyms,
    required this.antonyms,
    required this.definition,
    required this.example,
  })  : _definitions = definitions,
        definitions = definitions.asReadonly(),
        _isCreate = partOfSpeech.isEmpty;

  @override
  Future unload() {
    partOfSpeech.dispose();
    synonyms.dispose();
    antonyms.dispose();
    definition.dispose();
    example.dispose();

    return Future.value();
  }

  void addDefinition() {
    definition.setError(null);

    _setErrorIfEmpty(definition, definition.text);

    if (definition.text.isEmpty) {
      return;
    }

    updateState(
      () => _definitions.add(
        Definition(
          value: definition.textTrim,
          example: example.textTrim,
        ),
      ),
    );

    definition.clear();
    example.clear();
  }

  void editDefinition(int index) {
    updateState(() {
      final item = _definitions.removeAt(index);

      definition.setError(null);

      definition.setText(item.value);
      example.setText(item.example);

      definition.setFocus();
    });
  }

  void onDefinitionChanged(String value) => _setErrorIfEmpty(definition, value);
  void onPartOfSpeechChanged(String value) => _setErrorIfEmpty(partOfSpeech, value);

  void _setErrorIfEmpty(TextEditViewModel edit, String value) {
    if (value.isNotEmpty) {
      if (edit.error != null) {
        updateState(() => edit.clearError());
      }

      return;
    }

    updateState(() => edit.setError('can\'t be empty'));
  }

  void save(BuildContext context) {
    if (partOfSpeech.text.isEmpty) {
      updateState(() => partOfSpeech.setError('can\' be empty'));

      return;
    }

    final meaning = Meaning(
      partOfSpeech: partOfSpeech.text,
      definitions: _definitions,
      synonyms: _stringAsList(synonyms.textTrim),
      antonyms: _stringAsList(antonyms.textTrim),
    );

    MaterialNavigator.popWith(
      context,
      _isCreate ? CrudResult.create(meaning) : CrudResult.modify(meaning),
    );
  }

  static List<String> _stringAsList(String text) {
    if (text.isEmpty) {
      return List.empty();
    }

    return text
        .split(',')
        .map(
          (element) => element.trim(),
        )
        .where((element) => element.isNotEmpty)
        .toList();
  }
}
