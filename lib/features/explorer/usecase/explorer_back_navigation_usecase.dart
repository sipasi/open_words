import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/explorer/bloc/explorer_bloc.dart';

class ExplorerBackNavigationUsecase {
  static void handle(BuildContext context) {
    final bloc = context.read<ExplorerBloc>();

    bloc.add(ExplorerNavigateBackRequested());
  }
}
