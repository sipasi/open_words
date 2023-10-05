import 'package:flutter/material.dart';
import 'package:open_words/data/language_info.dart';
import 'package:open_words/view/shared/dialog/language_list_dialog.dart';

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
      onTap: () => LanguageListDialog.show(
        context: context,
        current: language.code,
        selected: selected,
      ),
    );
  }
}
