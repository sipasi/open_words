import 'package:flutter/material.dart';

class TextToSpeechCard extends StatelessWidget {
  final String origin;
  final String translation;

  final void Function(String value) onOriginTap;
  final void Function(String value) onTranslationTap;

  const TextToSpeechCard({
    super.key,
    required this.origin,
    required this.translation,
    required this.onOriginTap,
    required this.onTranslationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            title: Text(origin),
            subtitle: Text('Text to Speech'),
            trailing: Icon(Icons.volume_up_outlined),
            onTap: () => onOriginTap(origin),
          ),
          ListTile(
            title: Text(translation),
            subtitle: Text('Text to Speech'),
            trailing: Icon(Icons.volume_up_outlined),
            onTap: () => onTranslationTap(translation),
          ),
        ],
      ),
    );
  }
}
