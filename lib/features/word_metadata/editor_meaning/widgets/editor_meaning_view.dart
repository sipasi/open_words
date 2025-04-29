import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/word_metadata/editor_meaning/cubit/editor_meaning_cubit.dart';
import 'package:open_words/features/word_metadata/editor_meaning/widgets/editor_meaning_bottom_bar.dart';
import 'package:open_words/features/word_metadata/editor_meaning/widgets/editor_meaning_definition_list.dart';
import 'package:open_words/shared/bottom_sheet/editor/editor_bottom_sheet.dart';
import 'package:open_words/shared/input_fields/text_edit_controller.dart';
import 'package:open_words/shared/input_fields/text_edit_field.dart';

class EditorMeaningView extends StatefulWidget {
  const EditorMeaningView({super.key});

  @override
  State<EditorMeaningView> createState() => _EditorMeaningViewState();
}

class _EditorMeaningViewState extends State<EditorMeaningView> {
  late final TextEditController partOfSpeech;

  late final TextEditController synonyms;

  late final TextEditController antonyms;

  @override
  void initState() {
    super.initState();
    final meaning = context.read<EditorMeaningCubit>().initial;

    partOfSpeech = TextEditController.text(text: meaning?.partOfSpeech);
    synonyms = TextEditController.text(text: meaning?.synonyms.join(', '));
    antonyms = TextEditController.text(text: meaning?.antonyms.join(', '));
  }

  @override
  void dispose() {
    super.dispose();

    partOfSpeech.dispose();
    synonyms.dispose();
    antonyms.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<EditorMeaningCubit>();

    return EditorBottomSheet(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            EditorMeaningDefinitionList(),
            ListTile(
              title: TextEditField(
                controller: synonyms,
                onChanged: bloc.setSynonyms,
                border: InputBorder.none,
                label: 'Synonyms',
                textInputAction: TextInputAction.next,
              ),
            ),
            ListTile(
              title: TextEditField(
                controller: antonyms,
                onChanged: bloc.setAntonyms,
                border: InputBorder.none,
                label: 'Antonyms',
                textInputAction: TextInputAction.next,
              ),
            ),
            ListTile(
              title: TextEditField(
                controller: partOfSpeech,
                onChanged: bloc.setPartOfSpeech,
                border: InputBorder.none,
                label: 'Part Of Speech',
                textInputAction: TextInputAction.done,
              ),
            ),
          ],
        ),
      ),
      bottomBar: EditorMeaningBottomBar(),
      showDismissDialog: () => _showDismissDialog(context),
    );
  }

  bool _showDismissDialog(BuildContext context) {
    final bloc = context.read<EditorMeaningCubit>();

    if (bloc.isCreate) {
      return partOfSpeech.textTrim.isNotEmpty ||
          synonyms.textTrim.isNotEmpty ||
          antonyms.textTrim.isNotEmpty ||
          bloc.state.definitions.isNotEmpty;
    }

    final entity = bloc.initial!;

    return entity.partOfSpeech != partOfSpeech.textTrim ||
        entity.synonyms.join(', ') != synonyms.textTrim ||
        entity.antonyms.join(', ') != antonyms.textTrim ||
        listEquals(entity.definitions, bloc.state.definitions) == false;
  }
}
