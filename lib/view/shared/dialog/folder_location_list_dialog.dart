import 'package:flutter/material.dart';
import 'package:open_words/service/export/path_factory/folder_location.dart';
import 'package:open_words/view/shared/dialog/list_view_dialog.dart';

class FolderLocationListDialog {
  static Future show({
    required BuildContext context,
    required FolderLocation current,
    required void Function(FolderLocation value) selected,
  }) async {
    const values = FolderLocation.values;

    final value = await ListViewDialog.show<FolderLocation>(
      context: context,
      length: values.length,
      builder: (index) {
        final value = values[index];

        return ListTile(
          title: Text(value.label),
          trailing: const Icon(
            Icons.circle,
          ),
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
