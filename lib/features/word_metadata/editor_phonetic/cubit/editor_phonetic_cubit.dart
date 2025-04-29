import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/data/entities/metadata/phonetic.dart';

part 'editor_phonetic_state.dart';

class EditorPhoneticCubit extends Cubit<EditorPhoneticState> {
  final Phonetic? initial;

  bool get isCreate => initial == null;
  bool get isEdit => !isCreate;

  EditorPhoneticCubit({this.initial}) : super(EditorPhoneticState.initial()) {
    init();
  }

  void init() {
    if (initial == null) {
      return;
    }

    emit(EditorPhoneticState(value: initial!.value, audio: initial!.audio));
  }

  void setPhonetic(String value) => emit(state.copyWith(value: value));

  void setAudio(String value) => emit(state.copyWith(audio: value));
}
