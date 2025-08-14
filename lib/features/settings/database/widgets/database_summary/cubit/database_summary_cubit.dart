import 'package:open_words/features/settings/database/bloc/measure_cubit.dart';
import 'package:open_words/features/settings/database/models/time_measure_result.dart';

class DatabaseSummaryCubit extends MeasureCubit {
  DatabaseSummaryCubit(super.database);

  @override
  List<TimeMeasureInfo> getMeasures() {
    return [
      TimeMeasureInfo('Folders', () => database.managers.folders.count()),
      TimeMeasureInfo('Groups', () => database.managers.wordGroups.count()),
      TimeMeasureInfo('Words', () => database.managers.words.count()),
      TimeMeasureInfo('Phonetics', () => database.managers.phonetics.count()),
      TimeMeasureInfo('Meanings', () => database.managers.meanings.count()),
      TimeMeasureInfo(
        'Definitions',
        () => database.managers.definitions.count(),
      ),
    ];
  }
}
