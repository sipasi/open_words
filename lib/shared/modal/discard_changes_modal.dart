import 'package:flutter/material.dart';

class DiscardChangesModal extends StatelessWidget {
  const DiscardChangesModal({super.key});

  static Future<bool> dialog({required BuildContext context}) async {
    final result = await showDialog(
      context: context,
      builder: (context) => DiscardChangesModal(),
    );

    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Discard changes?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Discard'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
