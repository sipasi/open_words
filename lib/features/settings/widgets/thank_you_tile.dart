import 'package:flutter/material.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

class ThankYouTile extends StatelessWidget {
  const ThankYouTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Center(
          child: Text(
            'Thank you',
            style: context.textTheme.headlineLarge?.copyWith(
              color: context.colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
