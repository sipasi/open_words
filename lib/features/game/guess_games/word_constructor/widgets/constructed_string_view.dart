import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/game/guess_games/word_constructor/cubit/word_constructor_cubit.dart';

class ConstructedStringView extends StatelessWidget {
  final TextStyle? style;

  const ConstructedStringView({super.key, this.style});

  @override
  Widget build(BuildContext context) {
    final constructed = context.select(
      (WordConstructorCubit value) =>
          value.state.answerConstructor.constructedString,
    );

    return Text(constructed, style: style);
  }
}
