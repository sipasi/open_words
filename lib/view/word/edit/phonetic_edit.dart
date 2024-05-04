import 'package:flutter/material.dart';
import 'package:open_words/data/metadata/phonetic.dart';
import 'package:open_words/service/navigation/material_navigator.dart';
import 'package:open_words/service/result.dart';
import 'package:open_words/view/shared/text/text_edit_field.dart';
import 'package:open_words/view/shared/text/text_edit_view_model.dart';

import 'entity_edit_scaffold.dart';
import 'phonetic_edit_view_model.dart';

class PhoneticEdit extends StatefulWidget {
  final Phonetic? entity;

  const PhoneticEdit({super.key, this.entity});
  const PhoneticEdit.from({super.key, required this.entity});

  @override
  State<PhoneticEdit> createState() => _PhoneticEditState();

  static Future<Result> pageCreate(BuildContext context) {
    return MaterialNavigator.push(
      context,
      (context) => const PhoneticEdit(),
    );
  }

  static Future<Result> pageEdit(BuildContext context, Phonetic entity) {
    return MaterialNavigator.push(
      context,
      (context) => PhoneticEdit.from(entity: entity),
    );
  }
}

class _PhoneticEditState extends State<PhoneticEdit> {
  late final PhoneticEditViewModel viewmodel;

  @override
  void initState() {
    super.initState();

    final entity = widget.entity;

    viewmodel = entity == null
        ? PhoneticEditViewModel.create(updateState: setState)
        : PhoneticEditViewModel.edit(phonetic: entity.value, source: entity.audio, updateState: setState);
  }

  @override
  Widget build(BuildContext context) {
    return EntityEditScaffold(
      saveHeroTag: 'save_phonetic_hero',
      onSave: () => viewmodel.save(context),
      body: Column(
        children: [
          TextEditField(
            viewmodel: viewmodel.phonetic,
            onChanged: (value) => TextEditViewModel.setErrorIfEmpty(viewmodel.phonetic, setState),
            label: 'phonetic',
            border: const OutlineInputBorder(),
          ),
          const SizedBox(height: 10),
          TextEditField(
            viewmodel: viewmodel.source,
            label: 'source',
            border: const OutlineInputBorder(),
          ),
        ],
      ),
    );
  }
}
