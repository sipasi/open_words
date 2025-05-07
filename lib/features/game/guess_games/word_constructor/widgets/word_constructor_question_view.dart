import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/game/guess_games/word_constructor/cubit/word_constructor_cubit.dart';
import 'package:open_words/features/game/guess_games/word_constructor/widgets/constructed_parts_view.dart';
import 'package:open_words/features/game/guess_games/word_constructor/widgets/constructed_string_view.dart';
import 'package:open_words/features/game/guess_games/word_constructor/widgets/word_constructor_animated_word.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

class WordConstructorQuestionView extends StatelessWidget {
  const WordConstructorQuestionView({super.key});

  @override
  Widget build(BuildContext context) {
    final currentQuiz = context.select(
      (WordConstructorCubit value) => value.state.session.currentQuiz,
    );

    final bloc = context.read<WordConstructorCubit>();
    final session = bloc.state.session;

    final leavedWord =
        session.repository.atOrNull(session.position.index - 1)?.question;

    final textStyle = context.textTheme.bodyLarge?.copyWith(
      fontWeight: FontWeight.bold,
    );

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          WordConstructorAnimatedWord(
            arrivedWord: currentQuiz.question,
            leavedWord: leavedWord,
            lastWord: session.allQuizFinished,
          ),
          const SizedBox(height: 4),
          ConstructedStringView(style: textStyle),
          const SizedBox(height: 16),
          ConstructedPartsView(),
        ],
      ),
    );
  }
}
