import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/data/language_info.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/service/navigation/material_navigator.dart';
import 'package:open_words/service/result.dart';
import 'package:open_words/storage/word_group_storage.dart';
import 'package:open_words/view/mvvm/view_model.dart';
import 'package:open_words/view/shared/text/text_edit_view_model.dart';

abstract class WordGroupEditCreateViewModel {
  final TextEditViewModel name;

  LanguageInfo _origin;
  LanguageInfo _translation;

  LanguageInfo get origin => _origin;
  LanguageInfo get translation => _translation;

  WordGroupEditCreateViewModel(
    this.name,
    this._origin,
    this._translation,
  );

  Future onSave(BuildContext context);

  @protected
  Future trySaveAndPop({
    required BuildContext context,
    required WordGroup Function() builder,
    required Result Function(WordGroup group) popWith,
  }) async {
    final nameValue = name.textTrim;

    if (nameValue.isEmpty) {
      return;
    }

    final group = builder();

    final result = await GetIt.I.get<WordGroupStorage>().updateOrCreate(group);

    if (context.mounted) MaterialNavigator.popWith(context, popWith(result));
  }

  void onNameChange(UpdateState updateState) => TextEditViewModel.setErrorIfEmpty(name, updateState);

  void onOriginSelect(LanguageInfo origin, UpdateState updateState) => updateState(() => _origin = origin);

  void onTranslationSelect(LanguageInfo translation, UpdateState updateState) =>
      updateState(() => _translation = translation);
}
