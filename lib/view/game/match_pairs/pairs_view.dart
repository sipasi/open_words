import 'package:flutter/material.dart';
import 'package:open_words/view/game/game_progress_indicator.dart';
import 'package:open_words/view/game/match_pairs/expanded_column.dart';

class PairsView extends StatelessWidget {
  final String title;

  final int pairsCount;

  final double answeredPairsPercentage;

  final bool lastPack;
  final bool currentCompleted;

  final Widget Function(int index) originBuilder;
  final Widget Function(int index) translationBuilder;

  final void Function() onGameExitTap;
  final void Function() onNextPackTap;

  const PairsView({
    super.key,
    required this.title,
    required this.pairsCount,
    required this.answeredPairsPercentage,
    required this.lastPack,
    required this.currentCompleted,
    required this.originBuilder,
    required this.translationBuilder,
    required this.onGameExitTap,
    required this.onNextPackTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GameProgressIndicator(
                margin: const EdgeInsets.symmetric(vertical: 12.0),
                percentage: answeredPairsPercentage,
              ),
              _body(),
              _bottom(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Row(
          children: [
            ExpandedColumn(
              length: pairsCount,
              builder: (index) => originBuilder(index),
            ),
            ExpandedColumn(
              length: pairsCount,
              builder: (index) => translationBuilder(index),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottom(BuildContext context) {
    String nextButtonText = lastPack ? '' : 'Next';

    return Row(
      children: [
        IconButton.filledTonal(
          onPressed: onGameExitTap,
          icon: const Icon(Icons.arrow_back),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: FilledButton.tonal(
            onPressed: currentCompleted ? onNextPackTap : null,
            child: Text(nextButtonText),
          ),
        ),
      ],
    );
  }
}
