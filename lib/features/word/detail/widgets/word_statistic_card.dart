import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/word/detail/cubit/word_detail_page_cubit.dart';

class WordStatisticCard extends StatelessWidget {
  const WordStatisticCard({super.key});

  @override
  Widget build(BuildContext context) {
    final statistic = context.select(
      (WordDetailPageCubit value) => value.state.statistic,
    );

    return Card.outlined(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          if (statistic.answerCorrect > 0)
            _tile(
              number: statistic.answerCorrect,
              description: 'Right answers',
              color: Colors.green,
            ),
          if (statistic.answerIncorrect > 0)
            _tile(
              number: statistic.answerIncorrect,
              description: 'Wrong answers',
              color: Colors.red,
            ),
        ],
      ),
    );
  }

  Widget _tile({
    required int number,
    required String description,
    required Color color,
  }) {
    return ListTile(
      title: Text(
        number.toString(),
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(description),
      trailing: const Icon(Icons.scoreboard),
    );
  }
}
