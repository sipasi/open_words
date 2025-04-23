import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/core/services/language/translation/translator_option.dart';
import 'package:open_words/core/services/language/translation/translator_url_builder.dart';
import 'package:open_words/core/services/language/translation/translator_url_service.dart';
import 'package:open_words/features/settings/bloc/settings_bloc.dart';
import 'package:open_words/features/word/create_list/cubit/word_list_create_cubit.dart';
import 'package:open_words/shared/modal/translator_list_modal.dart';
import 'package:url_launcher/url_launcher.dart';

class WordListCreateBottomBar extends StatelessWidget {
  final translatorUrl = GetIt.I.get<TranslatorUrlService>();

  WordListCreateBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final option = context.select(
      (SettingsBloc value) => value.state.translatorOption,
    );

    return BottomAppBar(
      child: Row(
        spacing: 8,
        children: [
          FilledButton.tonalIcon(
            onPressed: () => _onTranslatorTap(context, option),
            onLongPress: () => _onLongPress(context),
            icon: Icon(Icons.translate_outlined),
            label: Text(option.name),
          ),
          Text(
            'hold to change',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  void _onTranslatorTap(BuildContext context, TranslatorOption option) async {
    final bloc = context.read<WordListCreateCubit>();

    if (bloc.state.originDraft.isEmpty) {
      return;
    }

    final request = TranslationRequest.languageInfo(
      source: bloc.group.origin,
      target: bloc.group.translation,
      word: bloc.state.originDraft,
    );

    final uri = translatorUrl.get(option).build(request);

    await launchUrl(uri);
  }

  void _onLongPress(BuildContext context) async {
    final settingsBloc = context.read<SettingsBloc>();

    final selected = await TranslatorListModal.dialog(
      context: context,
      current: settingsBloc.state.translatorOption,
    );

    if (selected == null) {
      return;
    }

    settingsBloc.add(SettingsTranslatorChanged(selected));
  }
}
