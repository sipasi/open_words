import 'package:flutter/material.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

class AppBarTitle extends StatelessWidget {
  final String title;
  final String? heroTag;

  const AppBarTitle({super.key, required this.title, this.heroTag});

  @override
  Widget build(BuildContext context) {
    final text = Text(
      title,
      style: context.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: context.colorScheme.secondary,
      ),
    );

    return switch (heroTag) {
      null => text,
      _ => Hero(tag: heroTag!, child: text),
    };
  }
}
