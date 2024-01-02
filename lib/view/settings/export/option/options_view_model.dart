import 'package:flutter/material.dart';
import 'package:open_words/service/export/formatter/format_options.dart';
import 'package:open_words/service/export/formatter/pdf_format_options.dart';
import 'package:open_words/theme/color/color_seed.dart';

abstract class OptionsViewModel {
  FormatOptions asOption();
}

class PdfOptionsViewModel extends OptionsViewModel {
  bool _print = false;
  ThemeMode _mode = ThemeMode.dark;
  int _color = 0;

  bool get print => _print;
  bool get notPrint => _print == false;
  ThemeMode get mode => _mode;
  int get color => _color;

  void setPrint(bool value) => _print = value;
  void setMode(ThemeMode value) => _mode = value;
  void setColor(int value) => _color = value;

  @override
  PdfFormatOptions asOption() => PdfFormatOptions(
        print: _print,
        scheme: _getScheme(),
      );

  ColorScheme _getScheme() => ColorScheme.fromSeed(
        seedColor: ColorSeed.values[_color].color,
        brightness: _mode == ThemeMode.dark ? Brightness.dark : Brightness.light,
      );
}
