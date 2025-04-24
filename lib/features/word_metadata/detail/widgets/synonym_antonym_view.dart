import 'package:flutter/material.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

class SynonymAntonymView extends StatelessWidget {
  final String name;
  final List<String> values;

  const SynonymAntonymView({
    super.key,
    required this.name,
    required this.values,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final defaultStyle = context.textDefaultStyle.copyWith(fontSize: 16);

    TextStyle title = defaultStyle.copyWith(
      fontWeight: FontWeight.bold,
      color: colorScheme.onSurface,
    );
    TextStyle details = defaultStyle.copyWith(color: colorScheme.tertiary);

    return Wrap(
      children: [
        Text('$name:', style: title),
        ...List.generate(values.length, (index) {
          final text = values[index];

          return InkWell(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text('$text;', style: details),
            ),
            onTap: () => onTap(text),
            onLongPress: () => onLongPress(text),
          );
        }),
      ],
    );
  }

  void onTap(String value) {}
  void onLongPress(String value) {}
}
