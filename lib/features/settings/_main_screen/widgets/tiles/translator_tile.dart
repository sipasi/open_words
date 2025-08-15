import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/settings/_main_screen/bloc/settings_bloc.dart';
import 'package:open_words/features/settings/translator_edit/translator_template_edit_page.dart';
import 'package:open_words/shared/navigation/material_navigator.dart';

class TranslatorTile extends StatelessWidget {
  const TranslatorTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        final translator = state.translatorTemplate;

        return ListTile(
          title: Text('Translator'),
          subtitle: Text(translator.brand.name),
          trailing: Icon(Icons.translate_outlined),
          onTap: () => context.push((context) => TranslatorTemplateEditPage()),
        );
      },
    );
  }
}
