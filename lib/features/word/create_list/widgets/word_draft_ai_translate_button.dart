import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/artificial_intelligence/ai_translator.dart';
import 'package:open_words/features/word/create_list/cubit/word_list_create_cubit.dart';
import 'package:open_words/shared/artificial_intelligence/ai_translator_button.dart';
import 'package:open_words/shared/input_fields/text_edit_controller.dart';

class WordDraftAiTranslateButton extends StatelessWidget {
  final TextEditController origin;
  final TextEditController translation;

  const WordDraftAiTranslateButton({
    super.key,
    required this.origin,
    required this.translation,
  });

  @override
  Widget build(BuildContext context) {
    final aiAvailable = context.select(
      (WordListCreateCubit value) => value.state.aiAvailable,
    );

    if (aiAvailable) {
      return const SizedBox.shrink();
    }

    final bloc = context.read<WordListCreateCubit>();

    return AiTranslatorButton(
      translator: AiTranslator(
        bridge: bloc.aiBridgeProvider.get(),
        source: bloc.group.origin.name,
        target: bloc.group.translation.name,
      ),
      text: () => origin.text,
      onSuccess: (response) {
        translation.addText(response);
        bloc.setTranslation(translation.text);
      },
    );
  }
}
