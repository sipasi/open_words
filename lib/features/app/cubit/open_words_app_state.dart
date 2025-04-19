part of 'open_words_app_cubit.dart';

final class OpenWordsAppState {
  final AppTheme theme;

  OpenWordsAppState({required this.theme});

  OpenWordsAppState copyWith({AppTheme? theme}) {
    return OpenWordsAppState(theme: theme ?? this.theme);
  }
}
