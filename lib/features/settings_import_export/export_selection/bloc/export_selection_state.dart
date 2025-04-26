part of 'export_selection_cubit.dart';

class ExportSelectionState {
  final List<WordGroup> groups;
  final Set<WordGroup> selected;

  bool get selectedAll => groups.length == selected.length;
  bool get allowNextStep => selected.isNotEmpty;

  const ExportSelectionState({required this.groups, required this.selected});
  const ExportSelectionState.initial() : groups = const [], selected = const {};

  ExportSelectionState copyWith({List<WordGroup>? groups, Set<WordGroup>? selected}) {
    return ExportSelectionState(
      groups: groups ?? this.groups,
      selected: selected ?? this.selected,
    );
  }
}
