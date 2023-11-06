import 'package:flutter/material.dart';

class GameEndDialog extends StatelessWidget {
  final void Function() onResults;
  final void Function() onRestart;
  final void Function() onExit;

  const GameEndDialog({
    super.key,
    required this.onResults,
    required this.onRestart,
    required this.onExit,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FilledButton.icon(
              icon: const Icon(Icons.history_edu),
              label: const Text('Results'),
              onPressed: onResults,
            ),
            const SizedBox(height: 10),
            FilledButton.tonalIcon(
              icon: const Icon(Icons.restart_alt),
              label: const Text('Restart'),
              onPressed: onRestart,
            ),
            const SizedBox(height: 10),
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
    required void Function() onResults,
    required void Function() onRestart,
    required void Function() onExit,
  }) {
    return showDialog(
      context: context,
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
