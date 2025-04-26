import 'package:open_words/core/data/entities/id.dart';
import 'package:open_words/core/data/repository/explorer_repository.dart';
import 'package:open_words/features/database/bloc/measure_cubit.dart';
import 'package:open_words/features/database/models/time_measure_result.dart';

class ExplorerTestCubit extends MeasureCubit {
  final ExplorerRepository repository;

  ExplorerTestCubit(super.database, this.repository);

  @override
  List<TimeMeasureInfo> getMeasures() {
    const id = Id.empty();

    return [TimeMeasureInfo('allByFolder', () => repository.allByFolder(id))];
  }
}
