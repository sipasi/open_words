import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/core/services/vibration/vibration_service.dart';
import 'package:open_words/features/game/guess_games/word_pairs/cubit/pairs_match_cubit.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

class AnimatedPairPartCard extends StatefulWidget {
  final Widget child;

  final bool disabled;
  final bool selected;

  final int partId;
  final bool isQuestionPart;

  final void Function() onTap;

  const AnimatedPairPartCard({
    super.key,
    required this.child,
    required this.disabled,
    required this.selected,
    required this.partId,
    required this.isQuestionPart,
    required this.onTap,
  });

  @override
  State<AnimatedPairPartCard> createState() => _AnimatedPairPartCardState();
}

class _AnimatedPairPartCardState extends State<AnimatedPairPartCard>
    with TickerProviderStateMixin {
  late final AnimationController correctController;
  late final AnimationController wrongController;

  @override
  void initState() {
    super.initState();

    correctController = AnimationController(
      vsync: this,
      duration: Duration.zero,
    );
    wrongController = AnimationController(vsync: this, duration: Duration.zero);
  }

  @override
  void dispose() {
    correctController.dispose();
    wrongController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: MultiBlocListener(
        listeners: [
          BlocListener<PairsMatchCubit, PairsMatchState>(
            listenWhen: (previous, current) {
              return current.selection.isBothCorrect != null;
            },
            listener: _onBothCorrect,
          ),
          BlocListener<PairsMatchCubit, PairsMatchState>(
            listenWhen: (previous, current) {
              return previous.session.currentQuiz !=
                  current.session.currentQuiz;
            },
            listener: _onCurrentQuizChanged,
          ),
        ],
        child: SizedBox(height: 200, child: _card()),
      ),
    );
  }

  Widget _card() {
    return Card.outlined(
          clipBehavior: Clip.antiAlias,
          color: widget.selected ? context.colorScheme.primary : null,
          child: InkWell(
            splashColor: Colors.transparent,
            onTap:
                widget.disabled || widget.selected
                    ? null
                    : () => widget.onTap(),

            child: widget.child,
          ),
        )
        .animate(controller: wrongController, autoPlay: false)
        .shake()
        .animate(controller: correctController, autoPlay: false)
        .fade(begin: 1, end: .3);
  }

  void _onCurrentQuizChanged(BuildContext _, PairsMatchState state) {
    correctController.reset();
    wrongController.reset();
  }

  void _onBothCorrect(BuildContext _, PairsMatchState state) {
    final selectedId =
        widget.isQuestionPart
            ? state.selection.question
            : state.selection.answer;

    if (selectedId != widget.partId) {
      return;
    }
    final vibration = GetIt.I.get<VibrationService>();

    if (state.selection.isBothCorrect!) {
      correctController.forward(from: 0);

      vibration.lightImpact(VibrationDuration.short);

      return;
    }

    wrongController.forward(from: 0);

    vibration.mediumImpact(VibrationDuration.medium);
  }
}
