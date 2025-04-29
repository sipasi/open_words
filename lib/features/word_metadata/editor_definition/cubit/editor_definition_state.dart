part of 'editor_definition_cubit.dart';

class EditorDefinitionState {
  final String value;
  final String example;

  bool get canNotSubmit => value.trim().isEmpty && example.trim().isEmpty;

  EditorDefinitionState({required this.value, required this.example});
  EditorDefinitionState.initial() : value = '', example = '';

  EditorDefinitionState copyWith({String? value, String? example}) {
    return EditorDefinitionState(
      value: value ?? this.value,
      example: example ?? this.example,
    );
  }
}
