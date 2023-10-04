import 'package:flutter/material.dart';
import 'package:open_words/theme/app_theme.dart';
import 'package:open_words/theme/theme_switcher.dart';

class ThemeSwitcherWidget extends StatefulWidget {
  final AppTheme initialTheme;
  final Widget child;

  const ThemeSwitcherWidget({
    super.key,
    required this.initialTheme,
    required this.child,
  });

  @override
  State<ThemeSwitcherWidget> createState() => ThemeSwitcherWidgetState();
}

class ThemeSwitcherWidgetState extends State<ThemeSwitcherWidget> {
  AppTheme? theme;

  void switchTheme(AppTheme theme) {
    setState(() {
      this.theme = theme;
    });
  }

  @override
  Widget build(BuildContext context) {
    theme = theme ?? widget.initialTheme;
    return ThemeSwitcher(
      data: this,
      child: widget.child,
    );
  }
}
