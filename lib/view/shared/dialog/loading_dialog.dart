import 'package:flutter/material.dart';
import 'package:open_words/service/navigation/material_navigator.dart';

class LoadingDialog extends StatelessWidget {
  final Future future;

  const LoadingDialog({super.key, required this.future});

  static Future show({required BuildContext context, required Future future}) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => LoadingDialog(
        future: Future.wait([
          Future.delayed(const Duration(seconds: 1)),
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
          MaterialNavigator.pop(context);
        } else if (snapshot.connectionState == ConnectionState.done ||
            snapshot.connectionState == ConnectionState.none) {
          MaterialNavigator.pop(context);
        }

        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Loading...', style: large),
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
