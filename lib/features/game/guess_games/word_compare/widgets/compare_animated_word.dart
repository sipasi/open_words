import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/core/services/vibration/vibration_service.dart';
import 'package:open_words/features/game/guess_games/word_compare/bloc/word_compare_bloc.dart';
import 'package:open_words/features/game/guess_games/word_compare/models/word_compare_answer_event.dart';
import 'package:open_words/features/game/shared/animated_word/animated_word_controller.dart';
import 'package:open_words/features/game/shared/animated_word/animated_word_switcher.dart';

class CompareAnimatedWord extends StatefulWidget {
  final String? leavedWord;
  final String arrivedWord;
  final bool lastWord;

  const CompareAnimatedWord({
    super.key,
    this.leavedWord,
    required this.arrivedWord,
    required this.lastWord,
  });

  @override
  State<CompareAnimatedWord> createState() => _CompareAnimatedWordState();
}

class _CompareAnimatedWordState extends State<CompareAnimatedWord>
    with TickerProviderStateMixin {
  late final StreamSubscription<WordCompareAnswerEvent> _answerSubscription;

  late final AnimatedWordController controller;

  @override
  void initState() {
    super.initState();

    final vibration = GetIt.I.get<VibrationService>();

    controller = AnimatedWordController(
      vsync: this,
      onCorrect: () => vibration.lightImpact(VibrationDuration.short),
      onIncorrect: () => vibration.lightImpact(VibrationDuration.medium),
    );

    _answerSubscription = context.read<WordCompareBloc>().answerEvents.listen((
      event,
    ) {
      event == WordCompareAnswerEvent.correct
          ? controller.startCorrect()
          : controller.startIncorect();
    });
  }

  @override
  void dispose() {
    _answerSubscription.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: AnimatedWordSwitcher(
        controller: controller,
        arrivedWord: widget.arrivedWord,
        previousWord: widget.leavedWord,
        lastWord: widget.lastWord,
        alignment: Alignment.center,
      ),
    );
  }
}
