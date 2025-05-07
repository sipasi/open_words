import 'package:flutter/material.dart';
import 'package:open_words/shared/navigation/material_navigator.dart';

class WordCompareNavigationView extends StatelessWidget {
  const WordCompareNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FilledButton.tonalIcon(
            onPressed: () {
              context.pop();
            },
            icon: Icon(Icons.close),
            label: Text('Exit'),
          ),
        ],
      ),
    );
  }
}
