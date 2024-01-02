import 'package:flutter/material.dart';
import 'package:open_words/service/export/formatter/export_format.dart';
import 'package:open_words/view/shared/dialog/list_view_dialog.dart';

class ExportFormatListDialog {
  static Future show({
    required BuildContext context,
    required ExportFormat current,
    required void Function(ExportFormat value) selected,
  }) async {
    const values = ExportFormat.values;

    final value = await ListViewDialog.show<ExportFormat>(
      context: context,
      length: values.length,
      builder: (index) {
        final value = values[index];

        return ListTile(
          title: Text(value.name),
          trailing: Text('.${value.extension}'),
          selected: current == value,
          onTap: () => Navigator.pop(context, values[index]),
        );
      },
    );

    if (value == null) {
      return;
    }

    selected(value);
  }
}
