import 'package:open_words/core/data/entities/id.dart';
import 'package:open_words/core/data/repository/word_repository.dart';
import 'package:open_words/features/settings/database/bloc/measure_cubit.dart';
import 'package:open_words/features/settings/database/models/time_measure_result.dart';

class WordRepositoryTestCubit extends MeasureCubit {
  final WordRepository repository;

  WordRepositoryTestCubit(super.database, this.repository);

  @override
  List<TimeMeasureInfo> getMeasures() {
    const id = Id.exist(4);

    return [TimeMeasureInfo('allByGroup', () => repository.allByGroup(id))];
  }
}
