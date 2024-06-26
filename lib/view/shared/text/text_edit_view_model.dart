import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/service/clipboard/clipboard_service.dart';
import 'package:open_words/view/mvvm/view_model.dart';

class TextEditViewModel {
  final _clipboard = GetIt.I.get<ClipboardService>();

  final TextEditingController controller;

  final FocusNode? focusNode;

  String? _error;
  String? get error => _error;

  bool get isEmpty => text.isEmpty;
  bool get isEmptyOrWhiteSpace => textTrim.isEmpty;

  String get text => controller.text;
  String get textTrim => controller.text.trim();

  TextEditViewModel({required this.controller, this.focusNode});
  TextEditViewModel.text({String? text, this.focusNode}) : controller = TextEditingController(text: text);

  void setText(String? text) => controller.text = text ?? '';
  void setError(String? text) => _error = text;
  void clearError() => _error = null;

  void clear() {
    HapticFeedback.vibrate();

    controller.clear();
  }

  Future copyToClipboard(BuildContext context) {
    return _clipboard.writeText(
      context,
      controller.text.trim(),
      vibrate: true,
      snackBar: true,
    );
  }

  Future pasteFromClipboard(BuildContext context, {bool replace = true, String seperator = ', '}) async {
    final result = await _clipboard.readText(
      context,
      vibrate: true,
      snackBar: false,
    );

    final clipboardText = result?.trim();

    if (clipboardText == null || clipboardText.isEmpty) {
      return;
    }

    if (replace) {
      controller.text = clipboardText;
      return;
    }

    final contollerText = controller.text.trim();

    controller.text = contollerText.isEmpty ? clipboardText : '$contollerText$seperator$clipboardText';
  }

  void setFocus() {
    focusNode?.requestFocus();
  }

  void dispose() {
    controller.dispose();
    focusNode?.dispose();
  }

  static void setErrorIfEmpty(TextEditViewModel edit, UpdateState updateState, [String message = 'can\'t be empty']) {
    if (edit.textTrim.isNotEmpty) {
      if (edit.error != null) {
        updateState(() => edit.clearError());
      }

      return;
    }

    updateState(() => edit.setError(message));
  }
}
