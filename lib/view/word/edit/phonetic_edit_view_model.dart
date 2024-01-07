import 'package:flutter/material.dart';
import 'package:open_words/data/metadata/phonetic.dart';
import 'package:open_words/service/navigation/material_navigator.dart';
import 'package:open_words/service/result.dart';
import 'package:open_words/view/mvvm/view_model.dart';
import 'package:open_words/view/shared/text/text_edit_view_model.dart';

class PhoneticEditViewModel {
  final bool _isCreate;

  final UpdateState updateState;

  final TextEditViewModel phonetic;
  final TextEditViewModel source;

  PhoneticEditViewModel.create({
    required this.updateState,
    String? phonetic,
    String? source,
  })  : phonetic = TextEditViewModel.text(text: phonetic),
        source = TextEditViewModel.text(text: source),
        _isCreate = true;
  PhoneticEditViewModel.edit({
    required this.updateState,
    String? phonetic,
    String? source,
  })  : phonetic = TextEditViewModel.text(text: phonetic),
        source = TextEditViewModel.text(text: source),
        _isCreate = false;

  void onPhonetocChanged(String value) => TextEditViewModel.setErrorIfEmpty(phonetic, updateState);

  void save(BuildContext context) {
    if (phonetic.text.isEmpty) {
      TextEditViewModel.setErrorIfEmpty(phonetic, updateState);

      return;
    }

    final entity = Phonetic(value: phonetic.text, audio: source.text);

    MaterialNavigator.popWith(context, _isCreate ? CrudResult.create(entity) : CrudResult.modify(entity));
  }
}
