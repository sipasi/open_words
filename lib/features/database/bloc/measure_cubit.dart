import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/collection/linq/sort_by.dart';
import 'package:open_words/core/data/sources/drift/app_drift_database.dart';
import 'package:open_words/features/database/bloc/measure_state.dart';
import 'package:open_words/features/database/models/time_measure_result.dart';

abstract class MeasureCubit extends Cubit<MeasureState> {
  final AppDriftDatabase database;

  MeasureCubit(this.database) : super(MeasureState.initial());

  List<TimeMeasureInfo> getMeasures();

  void init() {
    emit(state.copyWith(loading: false, mesures: getMeasures()));

    measure(1);
  }

  Future measure([int times = 1]) async {
    emit(state.copyWith(loading: true));

    for (var element in state.mesures) {
      await element.measure(times);
    }

    state.mesures.sortAscBy((item) => item.average.elapsed);

    emit(state.copyWith(loading: false));
  }
}
