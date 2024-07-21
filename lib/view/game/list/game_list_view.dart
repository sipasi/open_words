import 'package:flutter/material.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/view/game/flashcard/flashcard_game_page.dart';
import 'package:open_words/view/game/match_pairs/audio_pairs/audio_pairs_page.dart';
import 'package:open_words/view/game/match_pairs/word_pairs/word_pairs_page.dart';
import 'package:open_words/view/game/word_compare/origin_to_translation_page.dart';
import 'package:open_words/view/game/word_compare/translation_to_origin_page.dart';
import 'package:open_words/view/game/word_constructor/word_constructor_page.dart';
import 'package:open_words/view/shared/layout/separated_column.dart';

import 'game_section.dart';
import 'game_tile.dart';

class GameListView extends StatelessWidget {
  final WordGroup group;

  const GameListView({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return SeparatedColumn(
      separator: (context, index) => const SizedBox(height: 20),
      children: [
        GameSection(
          title: 'Compare',
          tiles: [
            GameTile(
              name: 'Origins',
              description: 'Compare original words to translations',
              needWords: 8,
              count: group.words.length,
              route: (builder) => OriginToTranslationPage(group: group),
            ),
            GameTile(
              name: 'Translations',
              description: 'Compare translations to their original words',
              needWords: 8,
              count: group.words.length,
              route: (builder) => TranslationToOriginPage(group: group),
            ),
          ],
        ),
        GameSection(
          title: 'Match',
          tiles: [
            GameTile(
              name: 'Word Pairs',
              description: 'Match original words to translations',
              needWords: 5,
              count: group.words.length,
              route: (builder) => WordPairsPage(group: group),
            ),
            GameTile(
              name: 'Audio Pairs',
              description: 'Match audio clips with translations',
              needWords: 5,
              count: group.words.length,
              route: (builder) => AudioPairsPage(group: group),
            ),
          ],
        ),
        GameSection(
          title: 'Constructor',
          tiles: [
            GameTile(
              name: 'Origin',
              description: 'Create words from given parts or letters',
              needWords: 5,
              count: group.words.length,
              route: (builder) => WordConstructorPage(group: group),
            ),
          ],
        ),
        GameSection(
          title: 'Flashcard',
          tiles: [
            GameTile(
              name: 'Origins',
              description: 'Learn words from flashcards',
              needWords: 5,
              count: group.words.length,
              route: (builder) => FlashcardGamePage(group: group),
            ),
            GameTile(
              name: 'Translations',
              description: 'Learn words from flashcards',
              needWords: 5,
              count: group.words.length,
              route: (builder) => FlashcardGamePage(group: group),
            ),
          ],
        ),
      ],
    );
  }
}
