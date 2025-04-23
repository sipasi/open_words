import 'package:flutter/material.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

class TitleWithDetailsText extends StatelessWidget {
  final String title;
  final String details;

  const TitleWithDetailsText({
    super.key,
    required this.title,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final defaultStyle = context.textDefaultStyle.copyWith(fontSize: 16);

    TextStyle titleStyle = defaultStyle.copyWith(
      fontWeight: FontWeight.bold,
      color: colorScheme.onSurface,
    );
    TextStyle detailsStyle = defaultStyle.copyWith(
      color: colorScheme.secondary,
    );

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: title, style: titleStyle),
          TextSpan(text: details, style: detailsStyle),
        ],
      ),
    );
  }
}
