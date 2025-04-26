import 'package:flutter/material.dart';
import 'package:open_words/features/settings_import_export/export_selected/models/export_extension.dart';
import 'package:open_words/shared/modal/list_view_modal.dart';

class ExportExtensionModal {
  static Future<ExportExtension?> dialog({
    required BuildContext context,
    required ExportExtension current,
  }) async {
    const values = ExportExtension.values;

    final value = await ListViewModal.dialog<ExportExtension>(
      context: context,
      length: values.length,
      builder: (index) {
        final value = values[index];
        final selected = current == value;

        return ListTile(
          title: Text(value.name),
          leading: selected ? Icon(Icons.check, size: 18) : null,
          trailing: Text(value.extension),
          selected: selected,
          onTap: () => Navigator.pop(context, values[index]),
        );
      },
    );

    return value;
  }
}
