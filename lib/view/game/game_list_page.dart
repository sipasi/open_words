import 'package:flutter/material.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/service/navigation/material_navigator.dart';
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
          _GameInfoTile(
            name: 'Compare Origins',
            needWords: 8,
            count: group.words.length,
            route: (builder) => OriginToTranslationPage(group: group),
          ),
          _GameInfoTile(
            name: 'Compare Translations',
            needWords: 8,
            count: group.words.length,
            route: (builder) => TranslationToOriginPage(group: group),
          ),
        ],
      ),
    );
  }
}

class _GameInfoTile extends StatelessWidget {
  final String name;

  final int needWords;

  final int count;

  final Widget Function(BuildContext) route;

  const _GameInfoTile({
    required this.name,
    required this.needWords,
    required this.count,
    required this.route,
  });

  bool _isNotEnough() => count < needWords;

  String _notEnoughMessage() {
    return 'To play $name game needs at least $needWords words\nYou have $count words';
  }

  @override
  Widget build(BuildContext context) {
    if (_isNotEnough()) {
      return ListTile(
        title: Text(name),
        subtitle: Text(
          _notEnoughMessage(),
          style: TextStyle(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
      );
    }

    return ListTile(
      title: Text(name),
      onTap: () => MaterialNavigator.push(
        context,
        route,
      ),
    );
  }
}
