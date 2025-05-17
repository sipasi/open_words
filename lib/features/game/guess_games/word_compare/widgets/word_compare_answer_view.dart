import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/game/guess_games/word_compare/bloc/word_compare_bloc.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

class WordCompareAnswerView extends StatelessWidget {
  const WordCompareAnswerView({super.key});

  @override
  Widget build(BuildContext context) {
    final session = context.select(
      (WordCompareBloc value) => value.state.session,
    );

    final quiz = session.currentQuiz;
    final variants = quiz.variants.length;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 600),
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 4 / 2,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        shrinkWrap: true,
        children: List.generate(variants, (index) {
          final bloc = context.read<WordCompareBloc>();

          return _button(
            context: context,
            text: quiz.getVariantTextAt(index),
            onTap: () {
              bloc.add(WordCompareAnswerRequested(quiz.variants[index]));
            },
          );
        }),
      ),
    );
  }

  Widget _button({
    required BuildContext context,
    required String text,
    required void Function() onTap,
  }) {
    final styleButton = OutlinedButton.styleFrom(
      side: BorderSide(width: 3.0, color: context.colorScheme.primary),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    );

    return OutlinedButton(
      style: styleButton,
      onPressed: onTap,
      child: Text(
        text,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
      ),
    );
  }
}
