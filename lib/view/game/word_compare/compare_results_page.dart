import 'package:flutter/material.dart';
import 'package:open_words/collection/readonly_list.dart';
import 'package:open_words/view/game/word_compare/choose_result.dart';
import 'package:open_words/view/game/word_compare/word_text_getter.dart';

class CompareResultsPage extends StatelessWidget {
  final IReadonlyList<ChooseResult> results;
  final WordTextGetter textGetter;

  const CompareResultsPage({
    super.key,
    required this.results,
    required this.textGetter,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          final item = results[index];

          final question = textGetter.question(item.question);
          final answer = textGetter.answer(item.answer);

          final right = textGetter.answer(item.question);

          return _tile(context, item, question, answer, right);
        },
      ),
    );
  }

  Widget _tile(
    BuildContext context,
    ChooseResult item,
    String question,
    String answer,
    String right,
  ) {
    return ListTile(
      leading: Container(
        width: 5,
        color: _getColor(context, item.correct),
      ),
      title: Text(question),
      subtitle: Text(right),
      trailing: item.correct
          ? null
          : Text(
              answer,
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
    );
  }

  Color _getColor(BuildContext context, bool correct) {
    return correct ? Colors.green.shade400 : Colors.red.shade400;
  }
}
