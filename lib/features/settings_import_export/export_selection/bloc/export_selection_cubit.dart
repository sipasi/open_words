import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/data/entities/word/word_group.dart';
import 'package:open_words/core/data/repository/word_group_repository.dart';

part 'export_selection_state.dart';

class ExportSelectionCubit extends Cubit<ExportSelectionState> {
  final WordGroupRepository groupRepository;

  ExportSelectionCubit({required this.groupRepository}) : super(ExportSelectionState.initial());

  Future init() async {
    emit(state.copyWith(groups: await groupRepository.all()));
  }

  void toggle(WordGroup group) {
    final selected = state.selected.toSet();

    if (selected.add(group) == false) {
      selected.remove(group);
    }

    emit(state.copyWith(selected: selected));
  }

  void toggleAll() {
    final selected = state.selected.toSet();

    selected.clear();

    if (!state.selectedAll) {
      selected.addAll(state.groups);
    }

    emit(state.copyWith(selected: selected));
  }
}
