import 'package:flutter/material.dart';
import 'package:open_words/features/game/quiz_end/widgets/answer_record_item.dart';
import 'package:open_words/features/game/quiz_end/widgets/score_message_view.dart';
import 'package:open_words/features/game/quiz_end/widgets/score_progress_view.dart';
import 'package:open_words/features/game/shared/history/answer_history.dart';
import 'package:open_words/features/game/shared/quiz/quiz_score.dart';
import 'package:open_words/shared/constants/list_padding_constans.dart';
import 'package:open_words/shared/layout/adaptive_grid_view.dart';
import 'package:open_words/shared/layout/extensions/list_padding_extension.dart';

class AnswerRecordListView extends StatelessWidget {
  final AnswerHistory history;
  final QuizScore score;

  const AnswerRecordListView({
    super.key,
    required this.history,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    const statisticOffset = 2;

    return AdaptiveGridView(
      padding: context.safeListViewPadding(
        extraBottom: ListPaddingConstans.bottomForFab,
      ),
      maxCrossAxisExtent: 500,
      mainAxisExtent: 130,
      itemCount: history.length + statisticOffset,
      itemBuilder: (context, index) {
        if (index == 0) {
          return ScoreMessageView(score: score);
        }
        if (index == 1) {
          return ScoreProgressView(score: score);
        }

        return AnswerRecordItem.fromAnswer(
          result: history[index - statisticOffset],
        );
      },
    );
  }
}
