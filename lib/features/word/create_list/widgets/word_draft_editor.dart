import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/core/services/language/translation/translator_url_builder.dart';
import 'package:open_words/core/services/language/translation/translator_url_service.dart';
import 'package:open_words/core/services/vibration/vibration_service.dart';
import 'package:open_words/features/word/create_list/cubit/word_list_create_cubit.dart';
import 'package:open_words/features/word/create_list/widgets/word_part_editor.dart';
import 'package:open_words/shared/input_fields/text_edit_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class WordDraftEditor extends StatelessWidget {
  final vibration = GetIt.I.get<VibrationService>();

  final translatorUrl = GetIt.I.get<TranslatorUrlService>();

  final TextEditController origin;
  final TextEditController translation;

  WordDraftEditor({super.key, required this.origin, required this.translation});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WordPartEditor(
          controller: origin,
          label: 'Origin',
          hint: 'Enter origin here',
        ),
        WordPartEditor(
          controller: translation,
          label: 'Translation',
          hint: 'Enter translation here',
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FilledButton.tonalIcon(
              onPressed: () => _onTranslator(context),
              icon: Icon(Icons.translate_outlined),
              label: Text('Translator'),
            ),

            FilledButton.icon(
              onPressed: () => _onAdd(context),
              icon: Icon(Icons.add),
              label: Text('Add'),
            ),
          ],
        ),
      ],
    );
  }

  void _onTranslator(BuildContext context) async {
    final bloc = context.read<WordListCreateCubit>();

    final request = TranslationRequest.languageInfo(
      source: bloc.group.origin,
      target: bloc.group.translation,
      word: origin.textTrim,
    );

    final uri = translatorUrl.build(request);

    await launchUrl(uri);
  }

  void _onAdd(BuildContext context) {
    final cubit = context.read<WordListCreateCubit>();

    cubit.addDraft(origin: origin.textTrim, translation: translation.textTrim);
  }
}
