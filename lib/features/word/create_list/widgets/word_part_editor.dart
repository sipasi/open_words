import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/core/services/clipboard/clipboard.dart';
import 'package:open_words/shared/input_fields/text_edit_controller.dart';
import 'package:open_words/shared/input_fields/text_edit_field.dart';

class WordPartEditor extends StatelessWidget {
  final TextEditController controller;
  final String label;
  final String hint;

  const WordPartEditor({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          spacing: 8,
          children: [
            TextEditField(
              controller: controller,
              hint: hint,
              border: InputBorder.none,
              textInputAction: TextInputAction.next,
              maxLines: 1,
              label: label,
            ),
            Row(
              children: [
                IconButton.filledTonal(
                  onPressed: _clearText,
                  icon: Icon(Icons.delete_outline),
                ),
                const Spacer(),
                OutlinedButton.icon(
                  onPressed: _copyToClipboard,
                  icon: Icon(Icons.copy_outlined),
                  label: Text('Copy'),
                ),
                const SizedBox(width: 12),
                OutlinedButton.icon(
                  onPressed: _pastFromClipboard,
                  icon: Icon(Icons.paste_outlined),
                  label: Text('Paste'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future _pastFromClipboard() async {
    final clipboard = GetIt.I.get<ClipboardService>();

    final value = await clipboard.getText();
    final trimmed = controller.textTrim;

    if (value.isEmpty) {
      return;
    }

    controller.setText(trimmed.isEmpty ? value : '$trimmed, $value');
  }

  Future _copyToClipboard() {
    final clipboard = GetIt.I.get<ClipboardService>();

    return clipboard.setText(controller.textTrim);
  }

  void _clearText() {
    controller.clear();
  }
}
