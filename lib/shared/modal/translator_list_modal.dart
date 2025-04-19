import 'package:flutter/material.dart';
import 'package:open_words/core/services/language/translation/translator_option.dart';
import 'package:open_words/shared/modal/list_view_modal.dart';

class TranslatorListModal {
  static Future<TranslatorOption?> dialog({
    required BuildContext context,
    required TranslatorOption current,
  }) async {
    final values = TranslatorOption.values;

    final value = await ListViewModal.dialog<TranslatorOption>(
      context: context,
      length: values.length,
      builder: (index) {
        final value = values[index];

        return ListTile(
          title: Text(value.name),
          trailing: Icon(Icons.translate_outlined),
          selected: current == value,
          onTap: () => Navigator.pop(context, value),
        );
      },
    );

    return value;
  }
}
