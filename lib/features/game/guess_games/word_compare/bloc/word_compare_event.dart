part of 'word_compare_bloc.dart';

sealed class WordCompareEvent {}

final class WordCompareStarted extends WordCompareEvent {
  WordCompareStarted();
}

final class WordCompareAnswerRequested extends WordCompareEvent {
  final Word value;

  WordCompareAnswerRequested(this.value);
}
