import 'package:flutter/material.dart';
import 'package:open_words/data/metadata/meaning.dart';
import 'package:open_words/service/navigation/material_navigator.dart';
import 'package:open_words/service/result.dart';
import 'package:open_words/view/shared/text/text_edit_field.dart';
import 'package:open_words/view/shared/text/text_edit_view_model.dart';
import 'package:open_words/view/word/edit/meaning_edit_view_model.dart';

import 'entity_edit_scaffold.dart';

class MeaningEdit extends StatefulWidget {
  static const double _spacing = 10;

  final Meaning? meaning;

  const MeaningEdit({super.key, this.meaning});

  @override
  State<MeaningEdit> createState() => _MeaningEditState();

  static Future<Result> pageCreate(BuildContext context) {
    return MaterialNavigator.push(
      context,
      (context) => const MeaningEdit(),
    );
  }

  static Future<Result> pageEdit(BuildContext context, Meaning meaning) {
    return MaterialNavigator.push(
      context,
      (context) => MeaningEdit(meaning: meaning),
    );
  }
}

class _MeaningEditState extends State<MeaningEdit> {
  late final MeaningEditViewModel viewmodel;

  @override
  void initState() {
    super.initState();

    final meaning = widget.meaning;

    viewmodel = MeaningEditViewModel(
      updateState: setState,
      definitions: meaning?.definitions.toList() ?? [],
      partOfSpeech: TextEditViewModel.text(text: meaning?.partOfSpeech),
      synonyms: TextEditViewModel.text(text: meaning?.synonyms.join(', ')),
      antonyms: TextEditViewModel.text(text: meaning?.antonyms.join(', ')),
      definition: TextEditViewModel.text(),
      example: TextEditViewModel.text(),
    );
  }

  @override
  void dispose() {
    super.dispose();

    viewmodel.unload();
  }

  @override
  Widget build(BuildContext context) {
    return EntityEditScaffold(
      padding: EdgeInsets.zero,
      saveHeroTag: 'save_meaning_hero',
      onSave: () => viewmodel.save(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: _infoFields(),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(10),
              child: _definitionFields(),
            ),
            const SizedBox(height: MeaningEdit._spacing),
            FilledButton.tonal(
              onPressed: viewmodel.addDefinition,
              child: const Text('Add definition'),
            ),
            const SizedBox(height: MeaningEdit._spacing),
            _definitionList(),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _infoFields() {
    return Column(
      children: [
        TextEditField(
          viewmodel: viewmodel.partOfSpeech,
          label: 'part of speech',
          border: const OutlineInputBorder(),
          onChanged: viewmodel.onPartOfSpeechChanged,
        ),
        const SizedBox(height: MeaningEdit._spacing),
        TextEditField(
          viewmodel: viewmodel.synonyms,
          label: 'synonyms',
          border: const OutlineInputBorder(),
          keyboardType: TextInputType.multiline,
          maxLines: null,
        ),
        const SizedBox(height: MeaningEdit._spacing),
        TextEditField(
          viewmodel: viewmodel.antonyms,
          label: 'antonyms',
          border: const OutlineInputBorder(),
          keyboardType: TextInputType.multiline,
          maxLines: null,
        ),
      ],
    );
  }

  Widget _definitionFields() {
    return Column(
      children: [
        const SizedBox(height: MeaningEdit._spacing),
        TextEditField(
          viewmodel: viewmodel.definition,
          label: 'definition',
          border: const OutlineInputBorder(),
          keyboardType: TextInputType.multiline,
          maxLines: null,
          onChanged: viewmodel.onDefinitionChanged,
        ),
        const SizedBox(height: MeaningEdit._spacing),
        TextEditField(
          viewmodel: viewmodel.example,
          label: 'example',
          border: const OutlineInputBorder(),
          keyboardType: TextInputType.multiline,
          maxLines: null,
        ),
      ],
    );
  }

  Widget _definitionList() {
    return Card(
      elevation: 5,
      child: ListView.separated(
          itemCount: viewmodel.definitions.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final definition = viewmodel.definitions[index];

            return ListTile(
              titleAlignment: ListTileTitleAlignment.top,
              title: Text(definition.value),
              subtitle: definition.example != null ? Text(definition.example!) : null,
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => viewmodel.editDefinition(index),
              ),
            );
          }),
    );
  }
}
