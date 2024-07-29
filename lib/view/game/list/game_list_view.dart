import 'package:flutter/material.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/view/game/guess_game/match_pairs/audio_pairs/audio_pairs_page.dart';
import 'package:open_words/view/game/guess_game/match_pairs/word_pairs/word_pairs_page.dart';
import 'package:open_words/view/game/guess_game/word_compare/compare_game_view.dart';
import 'package:open_words/view/game/guess_game/word_constructor/word_constructor_page.dart';
import 'package:open_words/view/game/view_word_game/flashcard/flashcard_game_page.dart';
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
              route: (builder) => CompareGameView.origins(words: group.words),
            ),
            GameTile(
              name: 'Translations',
              description: 'Compare translations to their original words',
              needWords: 8,
              count: group.words.length,
              route: (builder) => CompareGameView.translations(words: group.words),
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
              name: 'Origins',
              description: 'Create words from given parts or letters',
              needWords: 5,
              count: group.words.length,
              route: (builder) => WordConstructorPage.constructOrigins(group: group),
            ),
            GameTile(
              name: 'Translations',
              description: 'Create words from given parts or letters',
              needWords: 5,
              count: group.words.length,
              route: (builder) => WordConstructorPage.constructTranslations(group: group),
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
              route: (builder) => FlashcardGamePage.origins(group: group),
            ),
            GameTile(
              name: 'Translations',
              description: 'Learn words from flashcards',
              needWords: 5,
              count: group.words.length,
              route: (builder) => FlashcardGamePage.translations(group: group),
            ),
          ],
        ),
      ],
    );
  }
}
