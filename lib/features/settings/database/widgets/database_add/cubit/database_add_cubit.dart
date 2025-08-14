import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/data/sources/drift/app_drift_database.dart';
import 'package:open_words/features/settings/database/models/time_measure_result.dart';

part 'database_add_state.dart';

class DatabaseAddCubit extends Cubit<DatabaseAddState> {
  final AppDriftDatabase database;

  DatabaseAddCubit(this.database) : super(DatabaseAddState.initial());

  Future addFloder(int count) async {
    final now = DateTime.now();

    emit(state.copyWith(loading: true));

    final measure = TimeMeasureInfo(
      'Add folder',
      () => database.managers.folders.bulkCreate((o) {
        return List.generate(count, (index) => o(created: now, name: 'Folder'));
      }),
    );

    await measure.measure();

    emit(state.copyWith(loading: false, measure: measure));
  }

  Future addWords(int count) async {
    final now = DateTime.now();

    emit(state.copyWith(loading: true));

    final measure = TimeMeasureInfo('Add words', () async {
      final id = await database.managers.wordGroups.create((o) {
        return o(
          created: now,
          modified: now,
          languageOriginCode: 'code',
          languageOriginName: 'name',
          languageOriginNative: 'native',
          languageTranslationCode: 'code',
          languageTranslationName: 'name',
          languageTranslationNative: 'native',
          name: 'Group',
        );
      });

      await database.batch(
        (batch) => batch.insertAll(
          database.words,
          List.generate(
            count,
            (index) => WordsCompanion.insert(
              created: now,
              groupId: id,
              translation: 'translation',
              origin: 'origin',
            ),
          ),
        ),
      );
    });

    await measure.measure();

    emit(state.copyWith(loading: false, measure: measure));
  }
}
