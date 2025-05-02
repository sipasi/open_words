import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/data/entities/id.dart';
import 'package:open_words/features/explorer/bloc/explorer_bloc.dart';
import 'package:open_words/features/explorer/widgets/explorer_grid_view.dart';
import 'package:open_words/features/explorer_entity_editor/explorer_entity_editor.dart';
import 'package:open_words/shared/card/add_first_entity_card.dart';

class ExplorerScreen extends StatelessWidget {
  const ExplorerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ExplorerBloc>().state;

    if (state.isEmpty && state.loadStatus.isLoaded) {
      return AddFirstFolderOrGroupCard();
    }

    return PopScope(
      canPop: state.isRootFolder,
      onPopInvokedWithResult: (didPop, result) {
        final bloc = context.read<ExplorerBloc>();

        bloc.add(ExplorerNavigateBackRequested());
      },
      child: ExplorerGridView(folders: state.folders, groups: state.groups),
    );
  }
}

class AddFirstFolderOrGroupCard extends StatelessWidget {
  const AddFirstFolderOrGroupCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AddFirstEntityCard(
        icon: Icons.create_new_folder_outlined,
        title: 'Tap to add your first folder or group',
        onTap: () {
          ExplorerEntityEditor.show(
            context: context,
            parentFolder: const Id.empty(),
          );
        },
      ),
    );
  }
}
