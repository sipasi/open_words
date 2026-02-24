import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/core/services/vibration/vibration_service.dart';
import 'package:open_words/features/game/list/cubit/game_list_cubit.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

class GameListWordsSlider extends StatelessWidget {
  final vibration = GetIt.I.get<VibrationService>();

  GameListWordsSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final range = context.select(
      (GameListCubit value) => value.state.wordRange,
    );

    if (range.hasSelectableWordRange == false) {
      return const SizedBox.shrink();
    }

    return ListTile(
      title: Slider(
        year2023: false,
        padding: EdgeInsets.all(0),
        value: range.selectedValue,
        min: range.min,
        max: range.max,
        divisions: range.divisions,
        onChanged: (double value) {
          final cubit = context.read<GameListCubit>();

          cubit.setSelectedRangeValue(value);

          final range = cubit.state.wordRange;

          if (range.selectedMin || range.selectedMax) {
            vibration.mediumImpact(VibrationDuration.medium);
          } else {
            vibration.lightImpact(VibrationDuration.short);
          }
        },
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: getTextWidget(context),
      ),
    );
  }

  Widget getTextWidget(BuildContext context) {
    final defaultStyle = TextStyle(color: context.colorScheme.onSurfaceVariant);
    final primaryStyle = TextStyle(
      color: context.colorScheme.primary,
      fontWeight: FontWeight.bold,
    );

    final wordRange = context.read<GameListCubit>().state.wordRange;

    if (wordRange.selectedMin) {
      return RichText(
        text: TextSpan(
          style: defaultStyle,
          children: [
            TextSpan(text: 'Number of words is'),
            TextSpan(text: ' minimum ', style: primaryStyle),
            TextSpan(text: 'allowed'),
          ],
        ),
      );
    }
    if (wordRange.selectedMax) {
      return RichText(
        text: TextSpan(
          style: defaultStyle,
          children: [
            TextSpan(text: 'Number of words is'),
            TextSpan(text: ' maximum ', style: primaryStyle),
            TextSpan(text: 'allowed'),
          ],
        ),
      );
    }

    return RichText(
      text: TextSpan(
        style: defaultStyle,
        children: [
          TextSpan(text: 'Number of words is '),
          TextSpan(
            text: wordRange.selectedValue.round().toString(),
            style: primaryStyle,
          ),
        ],
      ),
    );
  }
}
