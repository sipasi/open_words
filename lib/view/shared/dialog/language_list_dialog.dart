import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/data/language_info.dart';
import 'package:open_words/service/language/language_info_service.dart';
import 'package:open_words/view/shared/dialog/list_view_dialog.dart';

class LanguageListDialog {
  static Future show({
    required BuildContext context,
    required String current,
    required void Function(LanguageInfo value) selected,
  }) async {
    final languages = GetIt.I.get<LanguageInfoService>();

    final value = await ListViewDialog.show<LanguageInfo>(
      context: context,
      length: languages.count,
      builder: (index) {
        final language = languages.get(index);

        return ListTile(
          title: Text(language.name),
          subtitle: Text(language.native),
          trailing: Text(language.code),
          selected: current == language.code,
          onTap: () => Navigator.pop(context, language),
        );
      },
    );

    if (value == null) {
      return;
    }

    selected(value);
  }
}
