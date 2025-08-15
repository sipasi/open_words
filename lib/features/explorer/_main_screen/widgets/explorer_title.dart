import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/explorer/_main_screen/bloc/explorer_bloc.dart';
import 'package:open_words/shared/appbar/app_bar_title.dart';

class ExplorerTitle extends StatelessWidget {
  const ExplorerTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final exploredName = context.select(
      (ExplorerBloc value) => value.state.exploredName,
    );

    return AppBarTitle(title: exploredName);
  }
}
