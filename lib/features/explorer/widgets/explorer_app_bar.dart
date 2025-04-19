import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/explorer/bloc/explorer_bloc.dart';
import 'package:open_words/features/explorer/usecase/explorer_back_navigation_usecase.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

class ExplorerAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  const ExplorerAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Builder(
        builder: (context) {
          final exploredName = context.select(
            (ExplorerBloc value) => value.state.exploredName,
          );

          return Text(
            exploredName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: context.colorScheme.secondary,
            ),
          );
        },
      ),
      leading: _backBotton(context),
    );
  }

  Widget? _backBotton(BuildContext context) {
    final isRootFolder = context.select(
      (ExplorerBloc value) => value.state.isRootFolder,
    );

    if (isRootFolder) {
      return null;
    }

    return IconButton(
      onPressed: () => ExplorerBackNavigationUsecase.handle(context),
      icon: Icon(Icons.arrow_back),
    );
  }
}
