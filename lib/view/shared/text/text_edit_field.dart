import 'package:flutter/material.dart';
import 'package:open_words/view/shared/text/text_edit_view_model.dart';

class TextEditField extends StatelessWidget {
  final TextEditViewModel viewmodel;

  final void Function(String value)? onChanged;

  final String? label;
  final String? hint;

  final InputBorder? border;

  final TextInputType? keyboardType;
  final int? maxLines;

  const TextEditField({
    super.key,
    required this.viewmodel,
    this.onChanged,
    this.label,
    this.hint,
    this.border,
    this.keyboardType,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: viewmodel.controller,
      focusNode: viewmodel.focusNode,
      keyboardType: keyboardType,
      maxLines: maxLines,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        errorText: viewmodel.error,
        border: border,
      ),
    );
  }
}
