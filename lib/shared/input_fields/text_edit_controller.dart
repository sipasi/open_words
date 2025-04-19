import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextEditController {
  final TextEditingController controller;

  final FocusNode? focusNode;

  String? _error;
  String? get error => _error;

  bool get isEmpty => text.isEmpty;
  bool get isEmptyOrWhiteSpace => textTrim.isEmpty;
  bool get isNotEmptyOrWhiteSpace => textTrim.isNotEmpty;

  String get text => controller.text;
  String get textTrim => controller.text.trim();

  TextEditController({required this.controller, this.focusNode});
  TextEditController.text({String? text, this.focusNode})
    : controller = TextEditingController(text: text);

  void setText(String? text) => controller.text = text ?? '';
  void setError(String? text) => _error = text;

  void setErrorIfEmpty([String message = 'can\'t be empty']) {
    if (textTrim.isNotEmpty) {
      if (error != null) {
        clearError();
      }

      return;
    }

    setError(message);
  }

  void clearError() => _error = null;

  void clear() {
    HapticFeedback.vibrate();

    controller.clear();
  }

  void setFocus() {
    focusNode?.requestFocus();
  }

  void dispose() {
    controller.dispose();
    focusNode?.dispose();
  }
}
