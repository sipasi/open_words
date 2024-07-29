import 'package:flutter/material.dart';
import 'package:open_words/service/navigation/material_navigator.dart';
import 'package:open_words/view/game/game_bottom_navigation.dart';
import 'package:open_words/view/game/word_game.dart';
import 'package:open_words/view/shared/layout/constraints_adaptive_layout.dart';

typedef WordGamePortraitBuilder = Widget Function(
  BuildContext context,
  Widget progress,
  Widget body,
  Widget? helpers,
  Widget bottom,
  EdgeInsets padding,
);
typedef WordGameLandscapeBuilder = Widget Function(
  BuildContext context,
  Widget progress,
  Widget body,
  Widget? helpers,
  Widget? landscapeDivider,
  Widget bottom,
  EdgeInsets padding,
);

class WordGameScreen extends StatelessWidget {
  final WordGame game;

  final WidgetBuilder bodyBuilder;
  final WidgetBuilder progressBuilder;
  final WidgetBuilder? helpersBuilder;
  final WidgetBuilder? landscapeDividerBuilder;

  final EdgeInsets bottomMargin;
  final EdgeInsets screenMargin;

  final WordGamePortraitBuilder? portraitBuilder;
  final WordGameLandscapeBuilder? landscapeBuilder;

  final void Function() onPrev;
  final void Function() onNext;

  const WordGameScreen({
    super.key,
    required this.game,
    required this.bodyBuilder,
    required this.progressBuilder,
    required this.onPrev,
    required this.onNext,
    this.bottomMargin = const EdgeInsets.all(0),
    this.screenMargin = const EdgeInsets.all(0),
    this.helpersBuilder,
    this.landscapeDividerBuilder,
    this.portraitBuilder,
    this.landscapeBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final progress = progressBuilder(context);
    final body = bodyBuilder(context);

    final landscapeDivider = landscapeDividerBuilder?.call(context);

    final helpers = helpersBuilder?.call(context);

    final bottom = GameBottomNavigation(
      margin: bottomMargin,
      exit: GameIconButton(
        icon: Icons.close,
        onPressed: () => MaterialNavigator.pop(context),
      ),
      prev: GameFilledButton(
        text: 'prev',
        canPressed: game.canPrev,
        onPressed: onPrev,
        visible: true,
      ),
      next: GameFilledButton(
        text: game.last ? 'finish' : 'next',
        canPressed: game.canNext,
        onPressed: onNext,
        visible: true,
      ),
    );

    return ConstraintsAdaptiveLayout(
      portrait: (context) => (portraitBuilder ?? _defaultPortraitLayout).call(
        context,
        progress,
        body,
        helpers,
        bottom,
        screenMargin,
      ),
      landscape: (context) => (landscapeBuilder ?? _defaultLandscapeLayout).call(
        context,
        progress,
        body,
        helpers,
        landscapeDivider,
        bottom,
        screenMargin,
      ),
    );
  }

  static WordGamePortraitBuilder get _defaultPortraitLayout => (
        context,
        progress,
        body,
        additional,
        bottom,
        padding,
      ) {
        return Padding(
          padding: padding,
          child: Column(
            children: [
              progress,
              if (additional != null) additional,
              body,
              bottom,
            ],
          ),
        );
      };
  static WordGameLandscapeBuilder get _defaultLandscapeLayout => (
        context,
        progress,
        body,
        additional,
        divider,
        bottom,
        padding,
      ) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: padding,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (additional != null) additional,
                    Expanded(
                      flex: additional == null ? 1 : 0,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: bottom,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (divider != null) divider,
            Expanded(
              child: Padding(
                padding: padding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    progress,
                    body,
                  ],
                ),
              ),
            )
          ],
        );
      };
}
