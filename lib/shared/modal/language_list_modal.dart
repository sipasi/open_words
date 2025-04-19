import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/core/data/entities/language_info.dart';
import 'package:open_words/core/services/language/language_info_service.dart';
import 'package:open_words/shared/modal/list_view_modal.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

class LanguageListModal {
  static Future<LanguageInfo?> showDialog({
    required BuildContext context,
    required String current,
  }) async {
    final languages = GetIt.I.get<LanguageInfoService>();

    final value = await ListViewModal.dialog<LanguageInfo>(
      context: context,
      length: languages.count,
      builder: (index) {
        final language = languages.get(index);

        final selected = current == language.code;

        return ListTile(
          title: Text(language.name),
          subtitle: Text(language.native),
          trailing: _wrapCircle(
            context: context,
            selected: selected,
            code: language.code,
          ),
          selected: selected,
          onTap: () => Navigator.pop(context, language),
        );
      },
    );

    return value;
  }

  static Widget _wrapCircle({
    required BuildContext context,
    required bool selected,
    required String code,
  }) {
    return Container(
      alignment: Alignment.center,
      width: 34,
      height: 34,
      decoration:
          selected
              ? BoxDecoration(
                shape: BoxShape.circle,
                color: context.colorScheme.secondaryContainer,
              )
              : null,
      child: Text(code),
    );
  }
}
