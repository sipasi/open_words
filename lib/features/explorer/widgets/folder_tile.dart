import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/core/data/entities/folder/folder.dart';
import 'package:open_words/core/services/vibration/vibration_service.dart';
import 'package:open_words/features/explorer/bloc/explorer_bloc.dart';
import 'package:open_words/features/explorer/widgets/explorer_grid_tile.dart';
import 'package:open_words/features/explorer_entity_editor/explorer_entity_editor.dart';
import 'package:open_words/features/explorer_entity_editor/models/explorer_entity_union.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

class FolderTile extends StatelessWidget {
  final Folder folder;

  const FolderTile({super.key, required this.folder});

  @override
  Widget build(BuildContext context) {
    return ExplorerGridTile(
      title: folder.name,
      titleStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: context.colorScheme.secondary,
      ),
      titleLines: 1,
      icon: Icon(Icons.folder, color: context.colorScheme.secondary),
      onTap: () => onTap(context, folder),
      onLongPress: () => onLongPress(context, folder),
    );
  }

  void onTap(BuildContext context, Folder value) {
    context.read<ExplorerBloc>().add(ExplorerNavigateRequested(folder: value));

    GetIt.I.get<VibrationService>().tap();
  }

  Future onLongPress(BuildContext context, Folder value) async {
    GetIt.I.get<VibrationService>().tap();

    ExplorerEntityEditor.show(
      context: context,
      parentFolder: context.read<ExplorerBloc>().state.exploredId,
      languageService: GetIt.I.get(),
      folderRepository: GetIt.I.get(),
      groupRepository: GetIt.I.get(),
      entityUnion: ExplorerEntityUnion.folder(value),
    );
  }
}
