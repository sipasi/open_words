part of 'import_picker_cubit.dart';

enum FilePickingStatus {
  picking,
  picked,
  pickedNothing;

  bool get isPicking => this == picking;
  bool get isNotPicking => !isPicking;
  bool get isPicked => this == picked;
  bool get isNothing => this == pickedNothing;
  bool get isPickedOrNothing => isPicked || isNothing;
}

class ImportPickerState {
  final List<WordGroupExport> groups;
  final Set<WordGroupExport> selected;
  final FilePickingStatus filePickingStatus;

  bool get selectedAll => selected.length == groups.length;

  ImportPickerState({
    required this.groups,
    required this.selected,
    required this.filePickingStatus,
  });
  ImportPickerState.initial()
    : groups = const [],
      selected = const {},
      filePickingStatus = FilePickingStatus.picking;

  ImportPickerState copyWith({
    List<WordGroupExport>? groups,
    Set<WordGroupExport>? selected,
    FilePickingStatus? filePickingStatus,
  }) {
    return ImportPickerState(
      groups: groups ?? this.groups,
      selected: selected ?? this.selected,
      filePickingStatus: filePickingStatus ?? this.filePickingStatus,
    );
  }
}
