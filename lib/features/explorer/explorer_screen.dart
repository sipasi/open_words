import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/explorer/bloc/explorer_bloc.dart';
import 'package:open_words/features/explorer/widgets/add_first_folder_or_group_card.dart';
import 'package:open_words/features/explorer/widgets/explorer_grid_view.dart';

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
