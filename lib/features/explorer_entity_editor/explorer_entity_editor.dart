import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/data/entities/id.dart';
import 'package:open_words/core/data/repository/folder_repository.dart';
import 'package:open_words/core/data/repository/word_group_repository.dart';
import 'package:open_words/core/services/language/language_info_service.dart';
import 'package:open_words/features/explorer/bloc/explorer_bloc.dart';
import 'package:open_words/features/explorer_entity_editor/cubit/explorer_entity_editor_cubit.dart';
import 'package:open_words/features/explorer_entity_editor/models/explorer_entity_union.dart';
import 'package:open_words/shared/bottom_sheet/bottom_sheet_choice_chip.dart';
import 'package:open_words/shared/bottom_sheet/pop_scope_bottom_sheet.dart';
import 'package:open_words/shared/input_fields/text_edit_controller.dart';
import 'package:open_words/shared/input_fields/text_edit_field.dart';
import 'package:open_words/shared/tiles/language_selector_tile.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

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
    required LanguageInfoService languageService,
    required FolderRepository folderRepository,
    required WordGroupRepository groupRepository,
    ExplorerEntityUnion? entityUnion,
  }) {
    return _pushModalSheetRoute(
      context: context,
      builder: (context) {
        return ExplorerEntityEditor(
          languageService: languageService,
          parentFolder: parentFolder,
          folderRepository: folderRepository,
          groupRepository: groupRepository,

          entityUnion: entityUnion,
        );
      },
    );
  }

  static Future _pushModalSheetRoute({
    required BuildContext context,
    required WidgetBuilder builder,
  }) {
    return Navigator.push(
      context,
      ModalSheetRoute(
        swipeDismissible: true,
        viewportPadding: EdgeInsets.only(
          // Add a top padding to avoid the status bar.
          top: MediaQuery.viewPaddingOf(context).top,
        ),
        builder: builder,
      ),
    );
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

    cubit = ExplorerEntityEditorCubit(languageService, widget.entityUnion);
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
        bottomBar: _EditorBottomBar(cubit: cubit, onSave: _onSave),
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
      parentId: widget.parentFolder,
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
      parentId: widget.parentFolder,
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

  const _EditorBottomBar({required this.cubit, required this.onSave});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: SafeArea(
        top: false,
        child: SizedBox.fromSize(
          size: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: _body(),
          ),
        ),
      ),
    );
  }

  Widget _body() {
    return Builder(
      builder: (context) {
        final createEntityType = context.select(
          (ExplorerEntityEditorCubit value) => value.state.createEntityType,
        );
        final canSave = context.select(
          (ExplorerEntityEditorCubit value) => value.state.canSave,
        );
        final editorType = context.read<ExplorerEntityEditorCubit>().editorType;

        return Row(
          children: [
            BottomSheetChoiceChip(
              context: context,
              text: 'Dictionary',
              icon: Icons.book_outlined,
              selected: createEntityType == CreateEntityType.wordGroup,
              interactable: editorType == EditorType.create,
              onTap: () {
                cubit.setGroupView();
              },
            ),
            const SizedBox(width: 8),
            BottomSheetChoiceChip(
              context: context,
              text: 'Folder',
              icon: Icons.folder_outlined,
              selected: createEntityType == CreateEntityType.folder,
              interactable: editorType == EditorType.create,
              onTap: () {
                cubit.setFolderView();
              },
            ),
            const Spacer(),
            IconButton.filled(
              onPressed: canSave ? onSave : null,
              icon: const Icon(Icons.arrow_upward),
              tooltip: 'Submit',
            ),
          ],
        );
      },
    );
  }
}
