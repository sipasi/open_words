import 'package:flutter/material.dart';
import 'package:open_words/view/shared/text/text_edit_field.dart';
import 'package:open_words/view/shared/text/text_edit_view_model.dart';

class TextEditCard extends StatelessWidget {
  final TextEditViewModel viewmodel;
  final bool autofocus;

  final EdgeInsets padding;
  final int offset;

  final void Function() onClear;
  final void Function() onCopy;
  final void Function() onPaste;

  const TextEditCard({
    super.key,
    required this.viewmodel,
    required this.onClear,
    required this.onCopy,
    required this.onPaste,
    this.autofocus = false,
    this.padding = const EdgeInsets.all(12.0),
    this.offset = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: padding,
        child: Column(
          children: [
            TextEditField(viewmodel: viewmodel),
            SizedBox(height: offset.toDouble()),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FilledButton.tonalIcon(
                  label: const Text('Clear'),
                  icon: const Icon(Icons.clear_all),
                  onPressed: onClear,
                ),
                const Spacer(),
                FilledButton.tonalIcon(
                  label: const Text('Copy'),
                  icon: const Icon(Icons.copy),
                  onPressed: () => onCopy(),
                ),
                const SizedBox(width: 10),
                FilledButton.tonalIcon(
                  label: const Text('Paste'),
                  icon: const Icon(Icons.paste),
                  onPressed: () => onPaste(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
