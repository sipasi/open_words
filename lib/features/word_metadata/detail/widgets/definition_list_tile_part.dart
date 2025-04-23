import 'package:flutter/material.dart';
import 'package:open_words/features/word_metadata/detail/widgets/title_with_details_text.dart';

class DefinitionListTilePart extends StatelessWidget {
  final String title;
  final String details;

  final void Function() onTap;
  final void Function() onLongPress;

  const DefinitionListTilePart({
    super.key,
    required this.title,
    required this.details,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: TitleWithDetailsText(title: title, details: details),
      ),
    );
  }
}
