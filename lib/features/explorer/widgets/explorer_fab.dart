import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/core/data/entities/id.dart';
import 'package:open_words/features/explorer/bloc/explorer_bloc.dart';
import 'package:open_words/features/explorer_entity_editor/explorer_entity_editor.dart';
import 'package:open_words/shared/constants/hero_tag_constants.dart';

class ExplorerFab extends StatelessWidget {
  const ExplorerFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: HeroTagConstants.fabDefaultTag,
      child: Icon(Icons.add),
      onPressed: () {
        _showCreateEditor(context);
      },
    );
  }

  Future _showCreateEditor(BuildContext context) {
    final exploredId = _getParentFolderId(context);

    return ExplorerEntityEditor.show(
      context: context,
      parentFolder: exploredId,
      languageService: GetIt.I.get(),
      folderRepository: GetIt.I.get(),
      groupRepository: GetIt.I.get(),
    );
  }

  Id _getParentFolderId(BuildContext context) {
    final bloc = context.read<ExplorerBloc>();

    return bloc.state.exploredId;
  }
}
