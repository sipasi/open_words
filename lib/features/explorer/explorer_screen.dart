import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/explorer/bloc/explorer_bloc.dart';
import 'package:open_words/features/explorer/usecase/explorer_back_navigation_usecase.dart';
import 'package:open_words/features/explorer/widgets/explorer_grid_view.dart';

class ExplorerScreen extends StatelessWidget {
  const ExplorerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ExplorerBloc>().state;

    return PopScope(
      canPop: state.isRootFolder,
      onPopInvokedWithResult: (didPop, result) {
        ExplorerBackNavigationUsecase.handle(context);
      },
      child: ExplorerGridView(folders: state.folders, groups: state.groups),
    );
  }
}
