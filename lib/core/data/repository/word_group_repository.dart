import 'package:drift/drift.dart';
import 'package:open_words/core/data/entities/id.dart';
import 'package:open_words/core/data/entities/language_info.dart';
import 'package:open_words/core/data/entities/word/word_group.dart';
import 'package:open_words/core/data/sources/drift/app_drift_database.dart';

sealed class WordGroupRepository {
  Future<List<WordGroup>> all();
  Future<List<WordGroup>> allByFolder(Id folder);
  Future<WordGroup?> byId(Id id);

  Future<WordGroup> create({
    required Id parentFolder,
    required String name,
    required LanguageInfo origin,
    required LanguageInfo translation,
  });

  Future<WordGroup> update({
    required Id id,
    required Id parentFolder,
    required String name,
    required LanguageInfo origin,
    required LanguageInfo translation,
  });
}

class WordGroupRepositoryImpl extends WordGroupRepository {
  final AppDriftDatabase database;

  WordGroupRepositoryImpl(this.database);

  @override
  Future<List<WordGroup>> all() {
    return database.managers.wordGroups.map(_mapGroup).get();
  }

  @override
  Future<List<WordGroup>> allByFolder(Id folder) {
    var query = database.allByFolderQuery(folder);

    return query
        .map(
          (row) => _mapGroup(
            database.wordGroups.map(row.data),
          ).copyWith(words: row.read<int>('words_count')),
        )
        .get();

    // return database.managers.wordGroups
    //     .filter((f) => f.folderId.id.equals(folder.valueOrNull()))
    //     .map(_mapGroup)
    //     .get();
  }

  @override
  Future<WordGroup?> byId(Id id) {
    return database.managers.wordGroups
        .filter((f) => f.id.equals(id.valueOrNull()))
        .map(_mapGroup)
        .getSingleOrNull();
  }

  @override
  Future<WordGroup> create({
    required Id parentFolder,
    required String name,
    required LanguageInfo origin,
    required LanguageInfo translation,
  }) async {
    final now = DateTime.now();

    final id = await database.managers.wordGroups.create(
      (o) => o(
        folderId: Value.absentIfNull(parentFolder.valueOrNull()),
        created: now,
        modified: now,
        name: name,
        origin: origin,
        translation: translation,
      ),
    );

    final entity = await byId(Id.exist(id));

    return entity!;
  }

  @override
  Future<WordGroup> update({
    required Id id,
    required Id parentFolder,
    required String name,
    required LanguageInfo origin,
    required LanguageInfo translation,
  }) async {
    final now = DateTime.now();

    await database.managers.wordGroups
        .filter((f) => f.id.equals(id.valueOrNull()))
        .update(
          (o) => o(
            folderId: Value.absentIfNull(parentFolder.valueOrNull()),
            modified: Value(now),
            name: Value(name),
            origin: Value(origin),
            translation: Value(translation),
          ),
        );

    final entity = await byId(id);

    return entity!;
  }

  WordGroup _mapGroup(DriftWordGroup element) {
    return WordGroup(
      id: Id.exist(element.id),
      folderId: Id.emptyIfNull(element.id),
      created: element.created,
      modified: element.modified,
      name: element.name,
      origin: element.origin,
      translation: element.translation,
      words: 0,
    );
  }
}

extension _Queries on AppDriftDatabase {
  Selectable<QueryRow> allByFolderQuery(Id folder) {
    final query =
        'SELECT *, '
        '(SELECT COUNT(*) FROM words WHERE group_id = g.id) AS "words_count" '
        'FROM word_groups g ';

    if (folder.isEmpty) {
      return customSelect('$query WHERE g.folder_id IS NULL;');
    }

    return customSelect(
      '$query WHERE g.folder_id = ?;',
      variables: [Variable.withInt(folder.valueOrThrow())],
    );
  }
}
