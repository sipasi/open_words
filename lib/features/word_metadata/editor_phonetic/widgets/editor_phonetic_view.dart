import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/word_metadata/editor_phonetic/cubit/editor_phonetic_cubit.dart';
import 'package:open_words/features/word_metadata/editor_phonetic/widgets/editor_phonetic_bottom_bar.dart';
import 'package:open_words/shared/bottom_sheet/editor/editor_bottom_sheet.dart';
import 'package:open_words/shared/input_fields/text_edit_controller.dart';
import 'package:open_words/shared/input_fields/text_edit_field.dart';

class EditorPhoneticView extends StatefulWidget {
  const EditorPhoneticView({super.key});

  @override
  State<EditorPhoneticView> createState() => _EditorPhoneticViewState();
}

final class _EditorPhoneticViewState extends State<EditorPhoneticView> {
  late final TextEditController phonetic;
  late final TextEditController audio;

  @override
  void initState() {
    super.initState();

    final initial = context.read<EditorPhoneticCubit>().initial;

    phonetic = TextEditController.text(text: initial?.value);
    audio = TextEditController.text(text: initial?.audio);
  }

  @override
  void dispose() {
    super.dispose();

    phonetic.dispose();
    audio.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<EditorPhoneticCubit>();

    return EditorBottomSheet(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            TextEditField(
              controller: phonetic,
              border: InputBorder.none,
              label: 'Phonetic',
              textInputAction: TextInputAction.next,
              onChanged: bloc.setPhonetic,
            ),
            TextEditField(
              controller: audio,
              border: InputBorder.none,
              label: 'Audio',
              textInputAction: TextInputAction.done,
              onChanged: bloc.setAudio,
            ),
          ],
        ),
      ),
      bottomBar: EditorPhoneticBottomBar(),
      showDismissDialog: _showDismissDialog,
    );
  }

  bool _showDismissDialog() {
    final bloc = context.read<EditorPhoneticCubit>();

    if (bloc.isCreate) {
      return bloc.state.canSubmit;
    }

    final entity = bloc.initial!;

    return entity.value != phonetic.textTrim || entity.audio != audio.textTrim;
  }
}
