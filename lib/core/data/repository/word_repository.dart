import 'package:open_words/core/data/draft/word_draft.dart';
import 'package:open_words/core/data/entities/id.dart';
import 'package:open_words/core/data/entities/word/word.dart';
import 'package:open_words/core/data/sources/drift/app_drift_database.dart';

sealed class WordRepository {
  Future<List<Word>> allByGroup(Id group);

  Future<int> create({
    required Id group,
    required String origin,
    required String translation,
  });

  Future addAll({required Id groupId, required List<WordDraft> drafts});
}

class WordRepositoryImpl extends WordRepository {
  final AppDriftDatabase database;

  WordRepositoryImpl(this.database);

  @override
  Future<List<Word>> allByGroup(Id group) {
    return database.managers.words
        .filter((f) => f.groupId.id.equals(group.valueOrNull()))
        .map(_mapWord)
        .get();
  }

  @override
  Future<int> create({
    required Id group,
    required String origin,
    required String translation,
  }) {
    final now = DateTime.now();

    return database.managers.words.create(
      (o) => o(
        groupId: group.valueOrThrow(),
        created: now,
        origin: origin,
        translation: translation,
      ),
    );
  }

  Word _mapWord(DriftWord element) {
    return Word(
      id: Id.exist(element.id),
      groupId: Id.exist(element.groupId),
      origin: element.origin,
      translation: element.translation,
    );
  }

  @override
  Future addAll({required Id groupId, required List<WordDraft> drafts}) {
    final now = DateTime.now();

    int id = groupId.valueOrThrow();

    return database.managers.words.bulkCreate(
      (o) => List.generate(drafts.length, (index) {
        final draft = drafts[index];

        return o(
          groupId: id,
          created: now,
          origin: draft.origin,
          translation: draft.translation,
        );
      }),
    );
  }
}
