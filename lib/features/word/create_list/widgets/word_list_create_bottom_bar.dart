import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/services/language/translation/translator_template.dart';
import 'package:open_words/features/settings/list/bloc/settings_bloc.dart';
import 'package:open_words/features/settings/translator_edit/translator_template_edit_modal.dart';
import 'package:open_words/features/word/create_list/cubit/word_list_create_cubit.dart';
import 'package:open_words/features/word/create_list/widgets/word_draft_ai_translate_button.dart';
import 'package:open_words/shared/input_fields/text_edit_controller.dart';

class WordListCreateBottomBar extends StatelessWidget {
  final TextEditController origin;
  final TextEditController translation;

  const WordListCreateBottomBar({
    super.key,
    required this.origin,
    required this.translation,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        spacing: 12,
        children: [
          WordDraftTranslatorLaunchButton(),
          WordDraftAiTranslateButton(
            origin: origin,
            translation: translation,
          ),
        ],
      ),
    );
  }
}

class WordDraftTranslatorLaunchButton extends StatelessWidget {
  const WordDraftTranslatorLaunchButton({super.key});

  @override
  Widget build(BuildContext context) {
    final template = context.select(
      (SettingsBloc value) => value.state.translatorTemplate,
    );

    return FilledButton.tonalIcon(
      onPressed: () => _onTranslatorTap(context, template),
      onLongPress: () => _onLongPress(context),
      icon: Icon(Icons.translate_outlined),
      label: Text(template.brand.name),
    );
  }

  void _onTranslatorTap(BuildContext context, TranslatorTemplate template) {
    context.read<WordListCreateCubit>().launchTranslator(template);
  }

  void _onLongPress(BuildContext context) async {
    final settingsBloc = context.read<SettingsBloc>();

    TranslatorTemplateEditModal.dialog(
      context: context,
      storage: settingsBloc.translatorStorage,
      bloc: settingsBloc,
      current: settingsBloc.translatorStorage.getOrDefault(),
    );
  }
}
