import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/services/language/translation/translator_option.dart';
import 'package:open_words/features/settings/bloc/settings_bloc.dart';
import 'package:open_words/features/word/create_list/cubit/word_list_create_cubit.dart';
import 'package:open_words/shared/modal/translator_list_modal.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

class WordListCreateBottomBar extends StatelessWidget {
  const WordListCreateBottomBar({super.key});

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
            style: TextStyle(
              fontSize: 12,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  void _onTranslatorTap(BuildContext context, TranslatorOption option) async {
    context.read<WordListCreateCubit>().launchTranslator(option);
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
