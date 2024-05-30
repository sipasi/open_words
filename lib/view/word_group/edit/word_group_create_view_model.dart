import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/service/language/language_info_service.dart';
import 'package:open_words/service/result.dart';
import 'package:open_words/view/shared/text/text_edit_view_model.dart';
import 'package:open_words/view/word_group/edit/word_group_edit_create_view_model.dart';

class WordGroupCreateViewModel extends WordGroupEditCreateViewModel {
  WordGroupCreateViewModel(super.name, super.origin, super.translation);

  @override
  Future onSave(BuildContext context) => trySaveAndPop(
        context: context,
        builder: () {
          final now = DateTime.now();

          return WordGroup(
            created: now,
            modified: now,
            name: name.textTrim,
            origin: origin,
            translation: translation,
            words: [],
          );
        },
        popWith: (group) => CrudResult.create(group),
      );

  static WordGroupCreateViewModel create() {
    final service = GetIt.I.get<LanguageInfoService>();

    return WordGroupCreateViewModel(
      TextEditViewModel.text(),
      service.getByCode('en'),
      service.getByCode('uk'),
    );
  }
}
