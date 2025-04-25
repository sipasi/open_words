import 'package:flutter/material.dart';
import 'package:open_words/core/data/entities/folder/folder_path.dart';
import 'package:open_words/shared/modal/list_view_modal.dart';

class FolderListModal {
  static Future<FolderPath?> dialog({
    required BuildContext context,
    required FolderPath? current,
    required List<FolderPath> values,
  }) async {
    if (!context.mounted) {
      return null;
    }

    final value = await ListViewModal.dialog<FolderPath>(
      context: context,
      length: values.length,
      builder: (index) {
        final value = values[index];

        return ListTile(
          title: Text(value.name),
          subtitle: Text(value.path),
          trailing: Icon(Icons.folder_outlined),
          selected: current == value,
          onTap: () => Navigator.pop(context, values[index]),
        );
      },
    );

    return value;
  }
}
