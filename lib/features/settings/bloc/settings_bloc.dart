import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/artificial_intelligence/bridge/ai_bridge_template.dart';
import 'package:open_words/core/services/ai_bridge/ai_bridge_provider.dart';
import 'package:open_words/core/services/language/translation/translator_template.dart';
import 'package:open_words/core/services/language/translation/translator_template_storage.dart';
import 'package:open_words/core/services/theme/theme_storage.dart';
import 'package:open_words/shared/theme/color_seed.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final ThemeStorage themeStorage;
  final TranslatorTemplateStorage translatorStorage;
  final AiBridgeProvider aiBridgeProvider;

  SettingsBloc({
    required this.themeStorage,
    required this.translatorStorage,
    required this.aiBridgeProvider,
  }) : super(SettingsState.initial()) {
    on<SettingsInitRequested>((event, emit) {
      final theme = themeStorage.get();
      final translator = translatorStorage.getOrDefault();
      final aiBridge = aiBridgeProvider.get();

      emit(
        state.copyWith(
          themeSeed: theme.seed,
          themeMode: theme.mode,
          translatorTemplate: translator,
          aiBridgeTemplate: AiBridgeTemplate.from(aiBridge),
        ),
      );
    });
    on<SettingsTranslatorChanged>((event, emit) {
      final state = this.state;

      translatorStorage.set(event.value);

      emit(state.copyWith(translatorTemplate: event.value));
    });
    on<SettingsAiBridgeChanged>((event, emit) async {
      final state = this.state;

      await aiBridgeProvider.set(event.value);

      emit(state.copyWith(aiBridgeTemplate: event.value));
    });
  }
}
