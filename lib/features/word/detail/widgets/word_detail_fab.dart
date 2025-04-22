import 'package:flutter/material.dart';
import 'package:open_words/shared/constants/hero_tag_constants.dart';

class WordDetailFab extends StatelessWidget {
  const WordDetailFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: HeroTagConstants.fabDefaultTag,
      child: Icon(Icons.menu),
      onPressed: () async {},
    );
  }
}
