import 'package:open_words/core/data/repository/word_metadata_repository.dart';
import 'package:open_words/features/settings/database/bloc/measure_cubit.dart';
import 'package:open_words/features/settings/database/models/time_measure_result.dart';

class MetadataRepositoryTestCubit extends MeasureCubit {
  final WordMetadataRepository repository;

  MetadataRepositoryTestCubit(super.database, this.repository);

  @override
  List<TimeMeasureInfo> getMeasures() {
    const list = ['', 'round', 'face', 'brown'];
    // ['round', 'face', 'brown']

    return [
      TimeMeasureInfo('byWord', () => repository.byWord('round')),
      TimeMeasureInfo('exist', () => repository.exist('round')),
      TimeMeasureInfo('mapOf ', () => repository.mapOf(list)),
    ];
  }
}
