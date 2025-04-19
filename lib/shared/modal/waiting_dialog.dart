import 'package:flutter/material.dart';
import 'package:open_words/shared/navigation/material_navigator.dart';

class WaitingDialog extends StatelessWidget {
  final String title;
  final Future future;

  const WaitingDialog({super.key, required this.title, required this.future});

  static Future show({
    required BuildContext context,
    required Future future,
    required String title,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => WaitingDialog(
            title: title,
            future: Future.wait([
              Future.delayed(const Duration(milliseconds: 800)),
              future,
            ]),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final large = TextStyle(
      fontSize: 24,
      color: Theme.of(context).colorScheme.secondary,
      fontWeight: FontWeight.bold,
    );

    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          context.pop();
        } else if (snapshot.connectionState == ConnectionState.done ||
            snapshot.connectionState == ConnectionState.none) {
          context.pop();
        }

        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: large),
                const SizedBox(height: 20),
                const CircularProgressIndicator(),
              ],
            ),
          ),
        );
      },
    );
  }
}
