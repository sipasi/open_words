import 'package:flutter/material.dart';
import 'package:open_words/view/shared/text/text_edit_view_model.dart';

class WordEditControl extends StatelessWidget {
  final TextEditViewModel translation;
  final EdgeInsetsGeometry padding;

  const WordEditControl({super.key, required this.translation, required this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextField(
        controller: translation.controller,
        decoration: const InputDecoration(labelText: 'translation'),
      ),
    );
  }
}
