import 'dart:async';

import 'package:flutter/material.dart';
import 'package:open_words/service/navigation/material_navigator.dart';
import 'package:open_words/view/game/answer_record/answer_record_list_page.dart';
import 'package:open_words/view/game/dialog/game_end_dialog.dart';
import 'package:open_words/view/mvvm/view_model.dart';

import 'word_guess_game.dart';

extension GuessGameEndDialog on WordGuessGame {
  Future showGameEndDialog(BuildContext context, UpdateState updateState) {
    return GameEndDialog.showDelayed(
      context: context,
      onResults: () => MaterialNavigator.push(
        context,
        (context) => AnswerRecordListPage(history: history),
      ),
      onRestart: () {
        MaterialNavigator.pop(context);

        updateState(() {
          restart();
        });
      },
      onExit: () => MaterialNavigator.pop(context, times: 2),
    );
  }

  Future showGameEndDialogDeleyed(
    BuildContext context,
    UpdateState updateState, {
    Duration duration = const Duration(milliseconds: 300),
  }) async {
    await Future.delayed(duration);

    if (!context.mounted) {
      return;
    }

    return showGameEndDialog(context, updateState);
  }
}
