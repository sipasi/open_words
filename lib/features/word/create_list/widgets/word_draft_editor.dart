import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/core/services/language/translation/translator_service.dart';
import 'package:open_words/core/services/vibration/vibration_service.dart';
import 'package:open_words/features/word/create_list/cubit/word_list_create_cubit.dart';
import 'package:open_words/features/word/create_list/widgets/word_part_editor.dart';
import 'package:open_words/shared/input_fields/text_edit_controller.dart';

class WordDraftEditor extends StatelessWidget {
  final vibration = GetIt.I.get<VibrationService>();

  final translatorUrl = GetIt.I.get<TranslatorService>();

  final TextEditController origin;
  final TextEditController translation;

  WordDraftEditor({super.key, required this.origin, required this.translation});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<WordListCreateCubit>();

    return Column(
      children: [
        WordPartEditor(
          controller: origin,
          label: bloc.group.origin.native,
          hint: 'Enter origin here',
          onChanged: bloc.setOrigin,
        ),
        WordPartEditor(
          controller: translation,
          label: bloc.group.translation.native,
          hint: 'Enter translation here',
          onChanged: bloc.setTranslation,
        ),
      ],
    );
  }
}
