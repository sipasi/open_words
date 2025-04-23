import 'package:flutter/material.dart';

class WordMetadataInfo extends StatelessWidget {
  final String origin;
  final String phonetic;

  final bool isPhoneticsEmpty;

  const WordMetadataInfo({
    super.key,
    required this.origin,
    required this.phonetic,
    required this.isPhoneticsEmpty,
  });

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      child: Column(
        children: [
          if (isPhoneticsEmpty && phonetic.isNotEmpty)
            ListTile(title: Text('Phonetic'), subtitle: Text(phonetic)),

          if (origin.isNotEmpty)
            ListTile(title: Text('Word history'), subtitle: Text(origin)),
        ],
      ),
    );
  }
}
