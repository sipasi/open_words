import 'package:open_words/features/settings/database/models/time_measure_result.dart';

class MeasureState {
  final bool loading;

  final List<TimeMeasureInfo> mesures;

  MeasureState({required this.loading, required this.mesures});

  MeasureState.initial() : loading = false, mesures = [];

  MeasureState copyWith({
    bool? loading,
    int? times,
    List<TimeMeasureInfo>? mesures,
  }) {
    return MeasureState(
      loading: loading ?? this.loading,
      mesures: mesures ?? this.mesures,
    );
  }
}
