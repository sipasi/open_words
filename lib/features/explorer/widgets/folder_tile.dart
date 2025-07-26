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
    final colorScheme = context.colorScheme;

    return ExplorerGridTile(
      title: folder.name,
      titleStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: colorScheme.secondary,
      ),
      icon: Icon(Icons.folder, color: colorScheme.secondary),
      iconBackground: colorScheme.secondaryContainer,
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
      entityUnion: ExplorerEntityUnion.folder(value),
    );
  }
}
