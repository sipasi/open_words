import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/game/guess_games/word_constructor/cubit/word_constructor_cubit.dart';
import 'package:open_words/features/game/guess_games/word_constructor/widgets/word_part_chips.dart';

class VariantPartsView extends StatelessWidget {
  const VariantPartsView({super.key});

  @override
  Widget build(BuildContext context) {
    final parts = context.select(
      (WordConstructorCubit value) =>
          value.state.session.currentQuiz.answerParts,
    );
    final answerConstructor = context.select(
      (WordConstructorCubit value) => value.state.answerConstructor,
    );

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ).copyWith(bottom: 64),
        child: WordPartChips(
          parts: parts,
          alignment: WrapAlignment.center,
          readonly: answerConstructor.constructed,
          isDisabled: answerConstructor.contains,
          onTap: (part) {
            context.read<WordConstructorCubit>().addConstructablePart(part);
          },
        ),
      ),
    );
  }
}
