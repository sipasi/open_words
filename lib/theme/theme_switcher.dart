import 'package:flutter/material.dart';
import 'package:open_words/theme/theme_switcher_widget.dart';

class ThemeSwitcher extends InheritedWidget {
  final ThemeSwitcherWidgetState data;

  const ThemeSwitcher({
    super.key,
    required super.child,
    required this.data,
  });

  static ThemeSwitcherWidgetState of(BuildContext context) {
    final switcher =
        context.dependOnInheritedWidgetOfExactType<ThemeSwitcher>();

    assert(switcher != null);

    return switcher!.data;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return this != oldWidget;
  }
}
