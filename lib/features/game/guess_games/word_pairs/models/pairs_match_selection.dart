import 'package:flutter/material.dart';

final class PairsMatchSelection {
  final int? question;
  final int? answer;

  final bool? isBothCorrect;

  bool get onlyQuestion => question != null;
  bool get onlyAnswer => answer != null;
  bool get both => onlyQuestion && onlyAnswer;

  const PairsMatchSelection({
    required this.question,
    required this.answer,
    required this.isBothCorrect,
  });
  const PairsMatchSelection.empty()
    : question = null,
      answer = null,
      isBothCorrect = null;

  PairsMatchSelection copyWithDeselection() {
    return PairsMatchSelection(
      question: null,
      answer: null,
      isBothCorrect: null,
    );
  }

  PairsMatchSelection copyWith({
    ValueGetter<int?>? question,
    ValueGetter<int?>? answer,
    ValueGetter<bool?>? isCorrect,
  }) {
    return PairsMatchSelection(
      question: question != null ? question() : this.question,
      answer: answer != null ? answer() : this.answer,
      isBothCorrect: isCorrect != null ? isCorrect() : isBothCorrect,
    );
  }
}
