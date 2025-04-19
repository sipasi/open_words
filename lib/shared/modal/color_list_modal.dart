import 'package:flutter/material.dart';
import 'package:open_words/shared/modal/list_view_modal.dart';
import 'package:open_words/shared/theme/color_seed.dart';

class ColorListModal {
  static Future<ColorSeed?> dialog({
    required BuildContext context,
    required ColorSeed current,
  }) async {
    const values = ColorSeed.values;

    final value = await ListViewModal.dialog<ColorSeed>(
      context: context,
      length: values.length,
      builder: (index) {
        final value = values[index];
        final color = values[index].color;

        return ListTile(
          title: Text(value.label),
          trailing: Icon(Icons.palette_outlined, color: color),
          selected: current == value,
          onTap: () => Navigator.pop(context, values[index]),
        );
      },
    );

    return value;
  }
}
