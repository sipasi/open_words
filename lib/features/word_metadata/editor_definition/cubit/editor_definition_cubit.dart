import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/data/entities/id.dart';
import 'package:open_words/core/data/entities/metadata/definition.dart';

part 'editor_definition_state.dart';

class EditorDefinitionCubit extends Cubit<EditorDefinitionState> {
  final Definition? initial;
  final Id meaningId;

  bool get isEdit => initial != null;

  bool get isCreate => !isEdit;

  EditorDefinitionCubit({required this.meaningId, this.initial})
    : super(EditorDefinitionState.initial()) {
    init();
  }

  void init() {
    if (initial == null) {
      return;
    }

    emit(state.copyWith(value: initial!.value, example: initial!.example));
  }

  void setValue(String value) => emit(state.copyWith(value: value));
  void setExample(String value) => emit(state.copyWith(example: value));
}
