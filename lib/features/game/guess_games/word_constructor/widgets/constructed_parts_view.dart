import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/game/guess_games/word_constructor/cubit/word_constructor_cubit.dart';
import 'package:open_words/features/game/guess_games/word_constructor/widgets/word_part_chips.dart';

class ConstructedPartsView extends StatelessWidget {
  const ConstructedPartsView({super.key});

  @override
  Widget build(BuildContext context) {
    final answerConstructor = context.select(
      (WordConstructorCubit value) => value.state.answerConstructor,
    );

    return WordPartChips(
      parts: answerConstructor.parts,
      readonly: answerConstructor.constructed,
      elevated: true,
      onTap: (part) {
        context.read<WordConstructorCubit>().removeConstructablePart(part);
      },
    );
  }
}
