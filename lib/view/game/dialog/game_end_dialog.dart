import 'package:flutter/material.dart';
import 'package:open_words/view/shared/layout/separated_column.dart';

class GameEndDialog extends StatelessWidget {
  final void Function() onExit;
  final void Function() onRestart;
  final void Function()? onResults;

  const GameEndDialog({
    super.key,
    this.onResults,
    required this.onRestart,
    required this.onExit,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SeparatedColumn(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          separator: (context, index) => const SizedBox(height: 10),
          children: [
            if (onResults != null)
              FilledButton.icon(
                icon: const Icon(Icons.history_edu),
                label: const Text('Results'),
                onPressed: onResults,
              ),
            FilledButton.tonalIcon(
              icon: const Icon(Icons.restart_alt),
              label: const Text('Restart'),
              onPressed: onRestart,
            ),
            FilledButton.tonalIcon(
              icon: const Icon(Icons.exit_to_app),
              label: const Text('Exit'),
              onPressed: onExit,
            ),
          ],
        ),
      ),
    );
  }

  static Future show({
    required BuildContext context,
    required void Function() onExit,
    required void Function() onRestart,
    void Function()? onResults,
    bool barrierDismissible = false,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (builder) {
        return GameEndDialog(
          onResults: onResults,
          onRestart: onRestart,
          onExit: onExit,
        );
      },
    );
  }
}
