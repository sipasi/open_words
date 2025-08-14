import 'package:open_words/core/data/entities/id.dart';
import 'package:open_words/core/data/repository/folder_repository.dart';
import 'package:open_words/features/settings/database/bloc/measure_cubit.dart';
import 'package:open_words/features/settings/database/models/time_measure_result.dart';

class FolderRepositoryTestCubit extends MeasureCubit {
  final FolderRepository repository;

  FolderRepositoryTestCubit(super.database, this.repository);

  @override
  List<TimeMeasureInfo> getMeasures() {
    final id = Id.exist(4580);

    return [
      TimeMeasureInfo('all', () => repository.all()),

      TimeMeasureInfo('oneById', () => repository.oneById(id)),

      TimeMeasureInfo('allPath', () => repository.allPath()),

      TimeMeasureInfo(
        'allMovablePathBy',
        () => repository.allMovablePathBy(id),
      ),
    ];
  }
}
