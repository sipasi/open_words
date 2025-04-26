import 'package:open_words/core/data/entities/id.dart';
import 'package:open_words/core/data/repository/word_group_repository.dart';
import 'package:open_words/features/database/bloc/measure_cubit.dart';
import 'package:open_words/features/database/models/time_measure_result.dart';

class GroupRepositoryTestCubit extends MeasureCubit {
  final WordGroupRepository repository;

  GroupRepositoryTestCubit(super.database, this.repository);

  @override
  List<TimeMeasureInfo> getMeasures() {
    final root = const Id.empty();

    return [
      TimeMeasureInfo('repository.all', () => repository.all()),
      TimeMeasureInfo(
        'repository.allByFolder',
        () => repository.allByFolder(root),
      ),
      TimeMeasureInfo('repository.byId', () => repository.oneById(Id.exist(1))),
    ];
  }
}
