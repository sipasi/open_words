import 'package:flutter/material.dart';

class GameBottomNavigation extends StatelessWidget {
  final EdgeInsetsGeometry margin;

  final GameIconButton exit;
  final GameFilledButton prev;
  final GameFilledButton next;

  const GameBottomNavigation({
    super.key,
    this.margin = const EdgeInsets.all(0),
    required this.exit,
    required this.prev,
    required this.next,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Row(
        children: [
          exit.toWidget(),
          if (prev.visible) const SizedBox(width: 12),
          prev.toExpandedWidget(),
          if (next.visible) const SizedBox(width: 8),
          next.toExpandedWidget(),
        ],
      ),
    );
  }
}

abstract class GameBottomButton {
  final bool canPressed;
  final GestureTapCallback onPressed;

  final bool visible;

  const GameBottomButton({required this.onPressed, this.canPressed = true, this.visible = true});

  @protected
  Widget toButton();

  Widget toWidget() {
    return Visibility(
      visible: visible,
      child: toButton(),
    );
  }

  Widget toExpandedWidget() {
    return Visibility(
      visible: visible,
      child: Expanded(
        child: toButton(),
      ),
    );
  }
}

class GameIconButton extends GameBottomButton {
  final IconData icon;

  const GameIconButton({required this.icon, required super.onPressed, super.canPressed, super.visible});

  @override
  Widget toButton() {
    return IconButton.filledTonal(
      onPressed: canPressed ? onPressed : null,
      icon: Icon(icon),
    );
  }
}

class GameFilledButton extends GameBottomButton {
  final String text;

  const GameFilledButton({required this.text, required super.onPressed, super.canPressed, super.visible});

  @override
  Widget toButton() {
    return FilledButton.tonalIcon(
      onPressed: canPressed ? onPressed : null,
      label: Text(text),
    );
  }
}
