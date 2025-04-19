import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/services/language/translation/translator_option.dart';
import 'package:open_words/features/settings/bloc/settings_bloc.dart';
import 'package:open_words/shared/modal/translator_list_modal.dart';

class TranslatorTile extends StatelessWidget {
  const TranslatorTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        if (state is! SettingsLoadSuccess) {
          return const SizedBox();
        }

        final translator = state.translatorOption;

        return ListTile(
          title: Text('Translator'),
          subtitle: Text(translator.name),
          trailing: Icon(Icons.translate_outlined),
          onTap: () => _onTap(context, translator),
        );
      },
    );
  }

  Future _onTap(BuildContext context, TranslatorOption current) async {
    final selected = await TranslatorListModal.dialog(
      context: context,
      current: current,
    );

    if (selected == null || !context.mounted) {
      return;
    }

    context.read<SettingsBloc>().add(SettingsTranslatorChanged(selected));
  }
}
