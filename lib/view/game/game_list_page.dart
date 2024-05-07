import 'package:flutter/material.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/service/navigation/material_navigator.dart';
import 'package:open_words/view/game/word_compare/origin_to_translation_page.dart';
import 'package:open_words/view/game/word_compare/translation_to_origin_page.dart';
import 'package:open_words/view/shared/list/adaptive_grid_view.dart';
import 'package:open_words/view/shared/tile/text_tile.dart';

class GameListPage extends StatelessWidget {
  final WordGroup group;

  const GameListPage({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Games')),
      body: SafeArea(
        child: AdaptiveGridView(
          maxCrossAxisExtent: 400,
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
    return 'To play needs at least $needWords words\nYou have $count words';
  }

  @override
  Widget build(BuildContext context) {
    final scheem = Theme.of(context).colorScheme;

    bool notEnough = _isNotEnough();

    return Card(
      child: TextTile(
        padding: const EdgeInsets.all(10.0),
        title: name,
        subtitle: notEnough ? _notEnoughMessage() : null,
        subtitleStyle: TextStyle(color: scheem.error),
        subtitleLines: 2,
        onTap: notEnough ? null : () => MaterialNavigator.push(context, route),
      ),
    );
  }
}
