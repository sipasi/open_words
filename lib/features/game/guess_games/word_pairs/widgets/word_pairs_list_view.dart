import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/game/guess_games/word_pairs/cubit/pairs_match_cubit.dart';
import 'package:open_words/features/game/guess_games/word_pairs/models/pairs_match_type.dart';
import 'package:open_words/features/game/guess_games/word_pairs/models/pairs_part.dart';
import 'package:open_words/features/game/guess_games/word_pairs/widgets/animated_card/audio_card.dart';
import 'package:open_words/features/game/guess_games/word_pairs/widgets/animated_card/text_card.dart';
import 'package:open_words/features/game/guess_games/word_pairs/widgets/expanded_column.dart';

class WordPairsListView extends StatelessWidget {
  const WordPairsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final currentQuiz = context.select(
      (PairsMatchCubit value) => value.state.session.currentQuiz,
    );
    final selection = context.select(
      (PairsMatchCubit value) => value.state.selection,
    );
    final matchType = context.select(
      (PairsMatchCubit value) => value.state.matchType,
    );

    final cubit = context.read<PairsMatchCubit>();

    const spacing = 16.0;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(spacing),
        child: Row(
          spacing: spacing,
          children: [
            columnFrom(
              context: context,
              spacing: spacing,
              parts: currentQuiz.questions,
              stateSetter: cubit.selectQuestion,
              selection: selection.question,
              isQuestionColumn: true,
              isAudio: matchType == PairsMatchType.audioToWord,
            ),
            columnFrom(
              context: context,
              spacing: spacing,
              parts: currentQuiz.variants,
              stateSetter: cubit.selectAnswer,
              selection: selection.answer,
              isQuestionColumn: false,
              isAudio: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget columnFrom({
    required BuildContext context,
    required double spacing,
    required List<PairsPart> parts,
    required void Function(int) stateSetter,
    required int? selection,
    required bool isQuestionColumn,
    required bool isAudio,
  }) {
    final cubit = context.read<PairsMatchCubit>();
    final matchedPairs = cubit.state.matchedPairs;

    return ExpandedColumn(
      spacing: spacing,
      length: parts.length,
      builder: (index) {
        final part = parts[index];

        bool selected = selection == index;

        if (isAudio) {
          return AudioCard(
            readonly: matchedPairs.contains(part),
            selected: selected,
            partId: index,
            isQuestionPart: isQuestionColumn,
            onTap: () {
              stateSetter(index);
            },
          );
        }

        return TextCard(
          text: part.text,
          readonly: matchedPairs.contains(part),
          selected: selected,
          partId: index,
          isQuestionPart: isQuestionColumn,
          onTap: () => stateSetter(index),
        );
      },
    );
  }
}
