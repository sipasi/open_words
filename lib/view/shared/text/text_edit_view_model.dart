import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_words/view/mvvm/view_model.dart';

class TextEditViewModel {
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

  Future copyToClipboard() async {
    final data = ClipboardData(text: controller.text.trim());

    await HapticFeedback.vibrate();

    await Clipboard.setData(data);
  }

  Future pasteFromClipboard() async {
    HapticFeedback.vibrate();

    final data = await Clipboard.getData(Clipboard.kTextPlain);

    if (data == null || data.text == null) {
      return;
    }

    controller.text = data.text!.trim();
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
