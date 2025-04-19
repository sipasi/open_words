import 'package:flutter/material.dart';
import 'package:open_words/core/data/entities/language_info.dart';
import 'package:open_words/shared/modal/language_list_modal.dart';

class LanguageSelectorTile extends StatelessWidget {
  final String title;
  final LanguageInfo language;

  final void Function(LanguageInfo value) selected;

  const LanguageSelectorTile({
    super.key,
    required this.title,
    required this.language,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(language.native),
      trailing: Text(language.code),
      textColor: Theme.of(context).colorScheme.secondary,
      onTap: () async {
        final result = await LanguageListModal.showDialog(
          context: context,
          current: language.code,
        );

        if (result == null) {
          return;
        }

        selected(result);
      },
    );
  }
}
