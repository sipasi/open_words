import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/explorer/_main_screen/bloc/explorer_bloc.dart';
import 'package:open_words/features/explorer/_main_screen/widgets/add_first_folder_or_group_card.dart';
import 'package:open_words/features/explorer/_main_screen/widgets/explorer_grid_view.dart';

class ExplorerScreen extends StatelessWidget {
  const ExplorerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ExplorerBloc>().state;

    final body = state.isEmpty && state.loadStatus.isLoaded
        ? AddFirstFolderOrGroupCard()
        : ExplorerGridView(folders: state.folders, groups: state.groups);

    return PopScope(
      canPop: state.isRootFolder,
      onPopInvokedWithResult: (didPop, result) {
        final bloc = context.read<ExplorerBloc>();

        bloc.add(ExplorerNavigateBackRequested());
      },
      child: body,
    );
  }
}
