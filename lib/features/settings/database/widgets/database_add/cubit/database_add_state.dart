part of 'database_add_cubit.dart';

class DatabaseAddState {
  final bool loading;
  final TimeMeasureInfo measure;

  DatabaseAddState({required this.loading, required this.measure});
  DatabaseAddState.initial()
    : loading = false,
      measure = TimeMeasureInfo('name', () => Future.value());

  DatabaseAddState copyWith({bool? loading, TimeMeasureInfo? measure}) {
    return DatabaseAddState(
      loading: loading ?? this.loading,
      measure: measure ?? this.measure,
    );
  }
}
