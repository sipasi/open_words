import 'package:flutter/material.dart';
import 'package:open_words/features/game/shared/history/answer_record.dart';

class AnswerRecordItem extends StatelessWidget {
  final bool correct;
  final String question;
  final String userAnswer;
  final String answer;

  const AnswerRecordItem({
    super.key,
    required this.correct,
    required this.question,
    required this.userAnswer,
    required this.answer,
  });
  AnswerRecordItem.fromAnswer({super.key, required AnswerRecord result})
    : correct = result.correct,
      question = result.question,
      userAnswer = result.userAnswer,
      answer = result.answer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final scheme = theme.colorScheme;

    final questionStyle = textTheme.bodyLarge?.copyWith(
      fontWeight: FontWeight.bold,
      color: scheme.onSurface,
      overflow: TextOverflow.ellipsis,
    );
    final correctStyle = textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.bold,
      color: scheme.onSurfaceVariant,
      overflow: TextOverflow.ellipsis,
    );
    final answerStyle = textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.bold,
      color: correct ? Colors.green : Colors.red,
      overflow: TextOverflow.ellipsis,
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(question, maxLines: 2, style: questionStyle),

                  if (correct) Text(answer, maxLines: 2, style: answerStyle),

                  if (correct == false)
                    RichText(
                      maxLines: 2,
                      text: TextSpan(
                        children: [
                          TextSpan(text: answer, style: correctStyle),
                          const TextSpan(text: ' - '),
                          TextSpan(text: userAnswer, style: answerStyle),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
