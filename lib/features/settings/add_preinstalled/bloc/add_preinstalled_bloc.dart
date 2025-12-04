import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/data/entities/id.dart';
import 'package:open_words/core/data/repository/folder_repository.dart';
import 'package:open_words/core/data/repository/word_group_repository.dart';
import 'package:open_words/core/data/repository/word_repository.dart';
import 'package:open_words/features/settings/add_preinstalled/model/preinstalled_pack.dart';
import 'package:open_words/features/settings/add_preinstalled/usecase/load_preinstalled_pack_usecase.dart';

part 'add_preinstalled_event.dart';
part 'add_preinstalled_state.dart';

class AddPreinstalledBloc
    extends Bloc<AddPreinstalledEvent, AddPreinstalledState> {
  final FolderRepository folderRepository;
  final WordGroupRepository groupRepository;
  final WordRepository wordRepository;

  AddPreinstalledBloc({
    required this.folderRepository,
    required this.groupRepository,
    required this.wordRepository,
  }) : super(const AddPreinstalledState.initial()) {
    on<AddPreinstalledLoadRequested>((event, emit) async {
      emit(state.copyWith(loadingStatus: LoadStatus.loading));

      final packs = await LoadPreinstalledPackUsecase.invoke();

      emit(
        state.copyWith(
          loadingStatus: LoadStatus.finished,
          packs: packs,
        ),
      );
    });

    on<AddPreinstalledPackTapped>((event, emit) async {
      final selected = state.selected.toSet();

      selected.contains(event.value)
          ? selected.remove(event.value)
          : selected.add(event.value);

      emit(
        state.copyWith(selected: selected),
      );
    });

    on<AddPreinstalledAddToLibraryRequested>((event, emit) async {
      emit(state.copyWith(addToLibraryStatus: AddToLibraryStatus.adding));

      for (final pack in state.selected) {
        final folderName =
            '${pack.name} ${pack.origin.native} - ${pack.translation.native}';

        final folder =
            await folderRepository.oneByName(folderName) ??
            await folderRepository.create(
              parentId: const Id.empty(),
              name: folderName,
            );

        for (final dictionary in pack.dictionaries) {
          if (await groupRepository.existByNameIn(
            dictionary.originName,
            folder.id,
          )) {
            continue;
          }

          final group = await groupRepository.create(
            folderId: folder.id,
            name: dictionary.originName,
            origin: pack.origin,
            translation: pack.translation,
          );

          await wordRepository.createAll(
            groupId: group.id,
            drafts: dictionary.words,
          );
        }
      }

      emit(state.copyWith(addToLibraryStatus: AddToLibraryStatus.finished));
    });
  }
}
