import 'package:flutter/material.dart';
import 'package:open_words/core/result/result.dart';
import 'package:open_words/features/game/quiz_end/models/quiz_end_result.dart';
import 'package:open_words/features/game/quiz_end/widgets/answer_record_list.view.dart';
import 'package:open_words/features/game/shared/history/answer_history.dart';
import 'package:open_words/features/game/shared/quiz/quiz_score.dart';
import 'package:open_words/shared/navigation/material_navigator.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

class QuizEndPage extends StatelessWidget {
  final AnswerHistory history;
  final QuizScore score;

  const QuizEndPage({super.key, required this.history, required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnswerRecordListView(history: history, score: score),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          FloatingActionButton.extended(
            heroTag: null,
            onPressed: () {
              context.popWith(Result.success(QuizEndResult.exit));
            },
            label: Text('Exit'),
            icon: Icon(Icons.exit_to_app_outlined),
          ),
          FloatingActionButton.extended(
            heroTag: null,
            onPressed: () {
              context.popWith(Result.success(QuizEndResult.restart));
            },
            label: Text('Replay'),
            foregroundColor: context.colorScheme.onPrimary,
            backgroundColor: context.colorScheme.primary,
            icon: Icon(Icons.restart_alt_outlined),
          ),
        ],
      ),
    );
  }
}
