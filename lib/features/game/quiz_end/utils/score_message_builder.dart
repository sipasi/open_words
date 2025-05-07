import 'package:open_words/features/game/shared/quiz/quiz_score.dart';

sealed class ScoreMessageBuilder {
  static String fromScore(QuizScore score) {
    return switch (score.correctAccuracy) {
      == 1 =>
        'Perfection achieved! That was absolutely breathtaking — a flawless performance worthy of applause 👏🔥',
      >= 0.9 => 'Outstanding! You really nailed it 🎯',
      >= 0.8 => 'Great job! You\'re on the right track 🌟',
      >= 0.6 => 'Nice effort! Keep pushing 💪',
      >= 0.4 => 'Not bad, but there\'s room to grow 🌱',
      _ => 'Don\'t worry, every expert was once a beginner. Try again! ♾️',
    };
  }
}
