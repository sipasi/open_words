import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/core/services/clipboard/clipboard.dart';
import 'package:open_words/core/services/vibration/vibration_service.dart';
import 'package:open_words/shared/input_fields/text_edit_controller.dart';
import 'package:open_words/shared/input_fields/text_edit_field.dart';

class TextFieldWithPaste extends StatelessWidget {
  final TextEditController controller;
  final String label;

  final void Function(String value)? onChanged;
  final void Function(String value)? onPaste;

  const TextFieldWithPaste({
    super.key,
    required this.controller,
    required this.label,
    required this.onChanged,
    required this.onPaste,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: TextEditField(
              controller: controller,
              label: label,
              border: OutlineInputBorder(),
              onChanged: onChanged,
            ),
          ),
          IconButton(
            icon: Icon(Icons.paste),
            onPressed: () async {
              final text = await _getClipboardText();

              if (text.isNotEmpty) {
                _vibrate();

                controller.setText(text);
                onPaste?.call(text);
              }
            },
          ),
        ],
      ),
    );
  }

  Future<String> _getClipboardText() {
    return GetIt.I.get<ClipboardService>().getText();
  }

  void _vibrate() {
    GetIt.I.get<VibrationService>().mediumImpact(VibrationDuration.medium);
  }
}
