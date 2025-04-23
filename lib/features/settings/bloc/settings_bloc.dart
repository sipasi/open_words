import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/services/language/translation/translator_option.dart';
import 'package:open_words/core/services/language/translation/translator_option_storage.dart';
import 'package:open_words/core/services/theme/theme_storage.dart';
import 'package:open_words/shared/theme/color_seed.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final ThemeStorage themeStorage;
  final TranslatorOptionStorage translatorOptionStorage;

  SettingsBloc({
    required this.themeStorage,
    required this.translatorOptionStorage,
  }) : super(SettingsState.initial()) {
    on<SettingsInitRequested>((event, emit) {
      final theme = themeStorage.get();
      final translatorOption = translatorOptionStorage.rememberedOrDefault();

      emit(
        state.copyWith(
          themeSeed: theme.seed,
          themeMode: theme.mode,
          translatorOption: translatorOption,
        ),
      );
    });
    on<SettingsTranslatorChanged>((event, emit) {
      final state = this.state;

      translatorOptionStorage.remember(event.value);

      emit(state.copyWith(translatorOption: event.value));
    });
  }
}
