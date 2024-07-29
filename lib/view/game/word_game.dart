import 'package:flutter/material.dart';

abstract class WordGame {
  int _position = 0;
  bool _gameEnd = false;

  final Function _onGameEnd;

  bool get last;

  bool get canPrev;
  bool get canNext;

  bool get gameEnd => _gameEnd;

  int get position => _position;

  WordGame({required Function onGameEnd}) : _onGameEnd = onGameEnd;

  void prev() {
    if (gameEnd) {
      return;
    }

    if (canPrev) _position--;
  }

  void next() {
    if (gameEnd) {
      return;
    }

    if (last) {
      _gameEnd = true;
      _onGameEnd();

      return;
    }

    if (canNext) _position++;
  }

  void init() {}

  @mustCallSuper
  void restart() {
    _position = 0;
    _gameEnd = false;
  }
}
