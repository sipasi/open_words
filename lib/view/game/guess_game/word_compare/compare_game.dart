import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:open_words/data/metadata/word_metadata.dart';
import 'package:open_words/data/word/word.dart';
import 'package:open_words/storage/metadata_storage.dart';
import 'package:open_words/view/game/answer_record/answer_record.dart';
import 'package:open_words/view/game/guess_game/solve_validator.dart';
import 'package:open_words/view/game/guess_game/word_compare/helper_text_list.dart';
import 'package:open_words/view/game/guess_game/word_question_side.dart';
import 'package:open_words/view/game/guess_game/word_source.dart';
import 'package:open_words/collection/list_random_extension.dart';

import '../word_guess_game.dart';
import 'compare_quiz_item.dart';

class CompareGame extends WordGuessGame {
  final _MetadataLoader _metadataLoader;

  final HelperTextList helpers;

  final void Function() onMetadataLoaded;

  @override
  CompareQuizItem get currentQuiz => super.currentQuiz as CompareQuizItem;

  @override
  AttemptTracker get attemptTracker => AttemptTracker.all;

  CompareGame({
    required super.totalSolved,
    required super.onGameEnd,
    required this.onMetadataLoaded,
    required super.quizzes,
    required super.validator,
    required MetadataStorage metadataStorage,
  })  : helpers = HelperTextList(),
        _metadataLoader = _MetadataLoader(metadataStorage);

  factory CompareGame.create({
    required List<Word> words,
    required WordQuestionSide questionSide,
    required void Function() onGameEnd,
    required void Function() onMetadataLoaded,
    required MetadataStorage metadataStorage,
    SolveValidator validate = SolveValidator.byVariantSide,
  }) {
    final quizzes = List.generate(
      words.length,
      (index) {
        final question = words[index];
        final variants = words.getRandom(count: 4, exclude: question);

        return CompareQuizItem(questionSide, question, variants);
      },
      growable: false,
    );

    return CompareGame(
      totalSolved: words.length,
      onGameEnd: onGameEnd,
      onMetadataLoaded: onMetadataLoaded,
      quizzes: QuizPack(quizzes),
      validator: validate,
      metadataStorage: metadataStorage,
    );
  }

  void updateState() {
    helpers.clear();

    _metadataLoader.load(
      getWordOrigin: () => currentQuiz.getQuestionText(),
      success: (metadata) {
        helpers.fillFrom(metadata);

        onMetadataLoaded();
      },
    );
  }

  @override
  void onAttemptedAsnwer(AnswerRecord record) {
    currentQuiz.markAsSolved();

    next();

    updateState();
  }

  @override
  void restart() {
    super.restart();

    helpers.clear();
  }
}

class _MetadataLoader {
  final Logger _logger = GetIt.I.get();

  final MetadataStorage metadataStorage;

  _MetadataLoader(this.metadataStorage);

  Future load({
    required String Function() getWordOrigin,
    required Function(WordMetadata metadata) success,
  }) async {
    final origin = getWordOrigin();

    final metadata = await metadataStorage.firstByWord(origin);

    if (metadata == null) {
      return;
    }

    final next = getWordOrigin();

    if (next != origin) {
      _logger.e('Differen cache.\nLook for {$origin but current $next');

      return;
    }

    success(metadata);
  }
}
