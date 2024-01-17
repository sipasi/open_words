import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({super.key});

  static Future<bool> show({required BuildContext context}) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) => const DeleteDialog(),
    );

    if (result is bool) {
      return result;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AlertDialog(
      title: Text(
        'Delete',
        style: TextStyle(
          color: colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: const Text('Do you realy want this?'),
      actions: [
        FilledButton.tonal(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('No'),
        ),
        const SizedBox(width: 6),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
