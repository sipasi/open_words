import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  final String title;

  const LoadingDialog({super.key, required this.title});

  static Future show({required BuildContext context, required String title}) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return LoadingDialog(title: title);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final large = TextStyle(
      fontSize: 24,
      color: Theme.of(context).colorScheme.secondary,
      fontWeight: FontWeight.bold,
    );

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
  }
}
