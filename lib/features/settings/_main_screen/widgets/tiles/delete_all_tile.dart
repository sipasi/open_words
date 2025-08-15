import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/core/data/sources/app_database.dart';
import 'package:open_words/features/explorer/_main_screen/bloc/explorer_bloc.dart';
import 'package:open_words/features/settings/_main_screen/widgets/settings_tile_button.dart';
import 'package:open_words/shared/modal/waiting_dialog.dart';

class DeleteAllTile extends StatelessWidget {
  const DeleteAllTile({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsTileButton(
      title: 'Delete all',
      icon: Icons.delete_forever_outlined,
      onTap: () {
        WaitingDialog.show(
          context: context,
          future: _deleteAll(context),
          title: 'Deliting',
        );
      },
    );
  }

  Future _deleteAll(BuildContext context) async {
    final database = GetIt.I.get<AppDatabase>();

    await database.clear();

    if (!context.mounted) {
      return;
    }

    context.read<ExplorerBloc>().add(ExplorerStarted());
  }
}
