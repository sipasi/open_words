import 'package:flutter/material.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

class MetadataNotFoundView extends StatelessWidget {
  const MetadataNotFoundView({super.key});

  @override
  Widget build(BuildContext context) {
    final surfaceColor = context.colorScheme.tertiaryContainer;
    final textColor = context.colorScheme.onTertiaryContainer;

    return Column(
      children: [
        const SizedBox(height: 12),
        Card(
          color: surfaceColor,
          child: ListTile(
            title: Text(
              'There is no metadata in local or web sources',
              style: TextStyle(color: textColor),
            ),
            leading: Icon(Icons.search_off, color: textColor),
          ),
        ),
        Card.filled(
          clipBehavior: Clip.antiAlias,
          child: ListTile(
            title: Text('You can add some metadata yourself'),
            leading: Icon(Icons.info_outline),
            onTap: () {},
          ),
        ),
      ],
    );
  }
}
