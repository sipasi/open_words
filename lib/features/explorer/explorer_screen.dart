import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/explorer/bloc/explorer_bloc.dart';
import 'package:open_words/features/explorer/widgets/explorer_grid_view.dart';

class ExplorerScreen extends StatelessWidget {
  const ExplorerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ExplorerBloc>().state;

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
