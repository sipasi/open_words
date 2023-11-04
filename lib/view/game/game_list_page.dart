import 'package:flutter/material.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/view/game/word_compare/origin_to_translation_page.dart';
import 'package:open_words/view/game/word_compare/translation_to_origin_page.dart';

class GameListPage extends StatelessWidget {
  final WordGroup group;

  const GameListPage({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Games')),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 2,
        children: [
          ListTile(
            title: const Text('Origin to translation'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (builder) => OriginToTranslationPage(
                  group: group,
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text('Translation to origin'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (builder) => TranslationToOriginPage(
                  group: group,
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text('Translation to origin'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Translation to origin'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
