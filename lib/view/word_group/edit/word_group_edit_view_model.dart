import 'package:flutter/material.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/service/result.dart';

import 'word_group_edit_create_view_model.dart';

class WordGroupEditViewModel extends WordGroupEditCreateViewModel {
  final WordGroup group;

  WordGroupEditViewModel(this.group, super.name, super.origin, super.translation);

  @override
  Future onSave(BuildContext context) => trySaveAndPop(
        context: context,
        builder: () => group.copyWith(
          modified: DateTime.now(),
          name: name.textTrim,
          origin: origin,
          translation: translation,
        ),
        popWith: (group) => CrudResult.modify(group),
      );
}
