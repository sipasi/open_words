import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/word_metadata/editor_definition/cubit/editor_definition_cubit.dart';
import 'package:open_words/features/word_metadata/editor_definition/widgets/editor_definition_bottom_bar.dart';
import 'package:open_words/shared/bottom_sheet/editor/editor_bottom_sheet.dart';
import 'package:open_words/shared/input_fields/text_edit_controller.dart';
import 'package:open_words/shared/input_fields/text_edit_field.dart';

class EditorDefinitionView extends StatefulWidget {
  const EditorDefinitionView({super.key});

  @override
  State<EditorDefinitionView> createState() => _EditorDefinitionViewState();
}

class _EditorDefinitionViewState extends State<EditorDefinitionView> {
  late final TextEditController definition;
  late final TextEditController example;

  @override
  void initState() {
    super.initState();

    final entity = context.read<EditorDefinitionCubit>().initial;

    definition = TextEditController.text(text: entity?.value);
    example = TextEditController.text(text: entity?.example);
  }

  @override
  void dispose() {
    super.dispose();

    definition.dispose();
    example.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<EditorDefinitionCubit>();

    return EditorBottomSheet(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            TextEditField(
              controller: definition,
              onChanged: bloc.setValue,
              border: InputBorder.none,
              label: 'Definition',
              textInputAction: TextInputAction.next,
            ),
            TextEditField(
              controller: example,
              onChanged: bloc.setExample,
              border: InputBorder.none,
              label: 'Example',
              textInputAction: TextInputAction.done,
            ),
          ],
        ),
      ),
      bottomBar: EditorDefinitionBottomBar(),
      showDismissDialog: () => _showDismissDialog(context),
    );
  }

  bool _showDismissDialog(BuildContext context) {
    final bloc = context.read<EditorDefinitionCubit>();

    if (bloc.isCreate) {
      return definition.textTrim.isNotEmpty || example.textTrim.isNotEmpty;
    }

    final entity = bloc.initial!;

    return entity.value != definition.textTrim ||
        entity.example != example.textTrim;
  }
}
