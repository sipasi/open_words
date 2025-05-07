import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/core/services/vibration/vibration_service.dart';
import 'package:open_words/features/game/guess_games/word_constructor/cubit/word_constructor_cubit.dart';
import 'package:open_words/features/game/shared/animated_word/animated_word_controller.dart';
import 'package:open_words/features/game/shared/animated_word/animated_word_switcher.dart';

class WordConstructorAnimatedWord extends StatefulWidget {
  final String? leavedWord;
  final String arrivedWord;
  final bool lastWord;

  const WordConstructorAnimatedWord({
    super.key,
    this.leavedWord,
    required this.arrivedWord,
    required this.lastWord,
  });

  @override
  State<WordConstructorAnimatedWord> createState() =>
      _WordConstructorAnimatedWordState();
}

class _WordConstructorAnimatedWordState
    extends State<WordConstructorAnimatedWord>
    with TickerProviderStateMixin {
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
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WordConstructorCubit, WordConstructorState>(
      listenWhen: (previous, current) {
        return previous.answerHistory != current.answerHistory;
      },
      listener: (context, state) {
        final lastOrNull = state.answerHistory.lastOrNull;

        if (lastOrNull == null) {
          return;
        }

        lastOrNull.correct
            ? controller.startCorrect()
            : controller.startIncorect();
      },
      child: AnimatedWordSwitcher(
        controller: controller,
        arrivedWord: widget.arrivedWord,
        previousWord: widget.leavedWord,
        lastWord: widget.lastWord,
        alignment: Alignment.centerLeft,
      ),
    );
  }
}
