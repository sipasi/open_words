import 'package:flutter/material.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

class WordInfoCard extends StatelessWidget {
  final String origin;
  final String translation;

  const WordInfoCard({
    super.key,
    required this.origin,
    required this.translation,
  });

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  origin,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              VerticalDivider(),
              Expanded(
                child: Text(
                  translation,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.secondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
