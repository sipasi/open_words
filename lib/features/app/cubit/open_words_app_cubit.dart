import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/services/theme/theme_storage.dart';
import 'package:open_words/shared/theme/app_theme.dart';
import 'package:open_words/shared/theme/color_seed.dart';

part 'open_words_app_state.dart';

class OpenWordsAppCubit extends Cubit<OpenWordsAppState> {
  final ThemeStorage themeStorage;

  OpenWordsAppCubit({required this.themeStorage})
    : super(OpenWordsAppState(theme: themeStorage.get()));

  void setTheme({
    ColorSeed? seed,
    ThemeMode? mode,
    bool? oledBackground,
    bool? oledBottomBar,
  }) {
    final current = themeStorage.get();

    seed = seed ?? current.seed;
    mode = mode ?? current.mode;
    oledBackground = oledBackground ?? current.oledBackground;

    AppTheme theme = AppTheme(
      mode: mode,
      seed: seed,
      oledBackground: oledBackground,
    );

    themeStorage.set(theme);

    emit(state.copyWith(theme: theme));
  }
}
