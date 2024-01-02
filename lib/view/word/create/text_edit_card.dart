import 'package:flutter/material.dart';

class TextEditCard extends StatelessWidget {
  final TextEditingController controller;
  final bool autofocus;
  final FocusNode? focusNode;

  final String? hint;
  final String? label;
  final String? error;

  final EdgeInsets padding;
  final int offset;

  final void Function() onClear;
  final void Function() onCopy;
  final void Function() onPaste;

  const TextEditCard({
    super.key,
    required this.controller,
    required this.onClear,
    required this.onCopy,
    required this.onPaste,
    this.autofocus = false,
    this.focusNode,
    this.padding = const EdgeInsets.all(12.0),
    this.offset = 12,
    this.hint,
    this.label,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: padding,
        child: Column(
          children: [
            TextField(
              controller: controller,
              autofocus: autofocus,
              focusNode: focusNode,
              decoration: InputDecoration(
                hintText: hint,
                labelText: label,
                errorText: error,
              ),
            ),
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
