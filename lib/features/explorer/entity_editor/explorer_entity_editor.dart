import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/core/data/entities/id.dart';
import 'package:open_words/core/data/repository/folder_repository.dart';
import 'package:open_words/core/data/repository/word_group_repository.dart';
import 'package:open_words/core/services/language/language_info_service.dart';
import 'package:open_words/features/explorer/_main_screen/bloc/explorer_bloc.dart';
import 'package:open_words/features/explorer/entity_editor/cubit/explorer_entity_editor_cubit.dart';
import 'package:open_words/features/explorer/entity_editor/models/explorer_entity_union.dart';
import 'package:open_words/shared/bottom_sheet/bottom_sheet_choice_chip.dart';
import 'package:open_words/shared/bottom_sheet/editor/editor_bottom_bar.dart';
import 'package:open_words/shared/bottom_sheet/pop_scope_bottom_sheet.dart';
import 'package:open_words/shared/input_fields/text_edit_controller.dart';
import 'package:open_words/shared/input_fields/text_edit_field.dart';
import 'package:open_words/shared/modal/folder_list_modal.dart';
import 'package:open_words/shared/navigation/material_navigator.dart';
import 'package:open_words/shared/tiles/language_selector_tile.dart';

class ExplorerEntityEditor extends StatefulWidget {
  final Id parentFolder;
  final LanguageInfoService languageService;
  final FolderRepository folderRepository;
  final WordGroupRepository groupRepository;

  final ExplorerEntityUnion? entityUnion;

  const ExplorerEntityEditor({
    super.key,
    required this.parentFolder,
    required this.languageService,
    required this.folderRepository,
    required this.groupRepository,
    this.entityUnion,
  });

  static Future show({
    required BuildContext context,
    required Id parentFolder,
    ExplorerEntityUnion? entityUnion,
  }) {
    return context.pushSmoothSheet((context) {
      return ExplorerEntityEditor(
        parentFolder: parentFolder,
        languageService: GetIt.I.get(),
        folderRepository: GetIt.I.get(),
        groupRepository: GetIt.I.get(),

        entityUnion: entityUnion,
      );
    });
  }

  @override
  State<ExplorerEntityEditor> createState() => _ExplorerEntityEditorState();
}

class _ExplorerEntityEditorState extends State<ExplorerEntityEditor> {
  late final LanguageInfoService languageService;

  late final FolderRepository folderRepository;
  late final WordGroupRepository groupRepository;

  late final ExplorerEntityEditorCubit cubit;

  late final TextEditController nameController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditController.text(
      text: widget.entityUnion?.getName(),
    );

    languageService = widget.languageService;
    folderRepository = widget.folderRepository;
    groupRepository = widget.groupRepository;

    cubit = ExplorerEntityEditorCubit(languageService, widget.entityUnion)
      ..init();
  }

  @override
  void dispose() {
    super.dispose();

    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: PopScopeBottomSheet(
        body: _EditorBody(cubit: cubit, nameController: nameController),
        bottomBar: _EditorBottomBar(
          cubit: cubit,
          onSave: _onSave,
          onDelete: _onDelete,
          onMove: _onMove,
        ),
        showDismissDialog: _showDismissDialog,
      ),
    );
  }

  bool _showDismissDialog() {
    final entityUnion = widget.entityUnion;
    final folder = entityUnion?.folder;
    final group = entityUnion?.group;

    final state = cubit.state;

    if (entityUnion == null) {
      return state.name.isNotEmpty;
    }

    if (folder != null) {
      return folder.name != state.name;
    }

    if (group != null) {
      return group.name != state.name ||
          group.origin != state.origin ||
          group.translation != state.translation;
    }

    return false;
  }

  Future _onSave() async {
    await (cubit.editorType == EditorType.create
        ? _createNew()
        : _saveExisted());

    final context = this.context;

    if (context.mounted) {
      context.read<ExplorerBloc>().add(ExplorerRefreshRequested());

      Navigator.pop(context);
    }
  }

  Future _onDelete() async {
    final state = cubit.state;

    final deleted = state.folderSelected
        ? folderRepository.delete(cubit.entityUnion!.folder!.id)
        : groupRepository.delete(cubit.entityUnion!.group!.id);

    await deleted;

    final context = this.context;

    if (context.mounted) {
      context.read<ExplorerBloc>().add(ExplorerRefreshRequested());

      Navigator.pop(context);
    }
  }

  Future _onMove() async {
    final id = (cubit.entityUnion!.folder ?? cubit.entityUnion!.group)!.id;

    final path = await FolderListModal.dialog(
      // ignore: use_build_context_synchronously
      context: context,
      current: null,
      values: await folderRepository.allMovablePathBy(id),
    );

    if (path == null) {
      return;
    }

    final move = cubit.state.folderSelected
        ? folderRepository.update(id: id, parentId: path.folderId)
        : groupRepository.update(id: id, folderId: path.folderId);

    await move;

    final c = context;

    if (c.mounted) {
      c.read<ExplorerBloc>().add(ExplorerRefreshRequested());

      Navigator.pop(c);
    }
  }

  Future _saveExisted() {
    final state = cubit.state;

    if (state.folderSelected) {
      return folderRepository.update(
        id: cubit.entityUnion!.folder!.id,
        parentId: widget.parentFolder,
        name: state.name,
      );
    }
    return groupRepository.update(
      id: cubit.entityUnion!.group!.id,
      folderId: widget.parentFolder,
      name: state.name,
      origin: state.origin,
      translation: state.translation,
    );
  }

  Future _createNew() {
    final state = cubit.state;

    if (state.folderSelected) {
      return folderRepository.create(
        parentId: widget.parentFolder,
        name: state.name,
      );
    }
    return groupRepository.create(
      folderId: widget.parentFolder,
      name: state.name,
      origin: state.origin,
      translation: state.translation,
    );
  }
}

class _EditorBody extends StatelessWidget {
  final ExplorerEntityEditorCubit cubit;
  final TextEditController nameController;

  const _EditorBody({required this.cubit, required this.nameController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [_inputField(context), _languageSection()],
    );
  }

  Widget _inputField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextEditField(
        controller: nameController,
        autofocus: true,
        maxLines: 1,
        onChanged: cubit.setName,
        style: Theme.of(context).textTheme.titleLarge,
        hint: 'Name',
        border: InputBorder.none,
      ),
    );
  }

  Widget _languageSection() {
    return Builder(
      builder: (context) {
        final folderSelected = context.select(
          (ExplorerEntityEditorCubit value) => value.state.folderSelected,
        );
        final origin = context.select(
          (ExplorerEntityEditorCubit value) => value.state.origin,
        );
        final translation = context.select(
          (ExplorerEntityEditorCubit value) => value.state.translation,
        );

        if (folderSelected) {
          return const SizedBox();
        }

        return Column(
          children: [
            LanguageSelectorTile(
              title: 'Origin',
              language: origin,
              selected: (value) {
                cubit.setOrigin(value);
              },
            ),

            LanguageSelectorTile(
              title: 'Translation',
              language: translation,
              selected: (value) {
                cubit.setTranslation(value);
              },
            ),
          ],
        );
      },
    );
  }
}

class _EditorBottomBar extends StatelessWidget {
  final ExplorerEntityEditorCubit cubit;

  final void Function() onSave;
  final void Function() onDelete;
  final void Function() onMove;

  const _EditorBottomBar({
    required this.cubit,
    required this.onSave,
    required this.onDelete,
    required this.onMove,
  });

  @override
  Widget build(BuildContext context) {
    final createEntityType = context.select(
      (ExplorerEntityEditorCubit value) => value.state.createEntityType,
    );
    final canSave = context.select(
      (ExplorerEntityEditorCubit value) => value.state.canSave,
    );

    final editorType = context.read<ExplorerEntityEditorCubit>().editorType;

    if (editorType == EditorType.create) {
      return EditorBottomBar(
        onSubmitPressed: canSave ? onSave : null,
        actions: [
          BottomSheetChoiceChip(
            text: 'Dictionary',
            icon: Icons.book_outlined,
            selected: createEntityType == CreateEntityType.wordGroup,
            interactable: editorType == EditorType.create,
            onTap: () {
              cubit.setGroupView();
            },
          ),
          BottomSheetChoiceChip(
            text: 'Folder',
            icon: Icons.folder_outlined,
            selected: createEntityType == CreateEntityType.folder,
            interactable: editorType == EditorType.create,
            onTap: () {
              cubit.setFolderView();
            },
          ),
        ],
      );
    }

    return EditorBottomBar(
      onSubmitPressed: canSave ? onSave : null,
      actions: [
        FilledButton.icon(
          onPressed: onDelete,
          icon: Icon(Icons.delete_outline),
          label: Text('Delete'),
        ),
        FilledButton.icon(
          onPressed: onMove,
          icon: Icon(Icons.drive_file_move_outlined),
          label: Text('Move'),
        ),
      ],
    );
  }
}
