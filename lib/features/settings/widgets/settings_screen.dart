import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/core/data/sources/app_database.dart';
import 'package:open_words/features/explorer/bloc/explorer_bloc.dart';
import 'package:open_words/shared/modal/waiting_dialog.dart';

class DeleteAllTile extends StatelessWidget {
  const DeleteAllTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.delete_forever_outlined),
      title: OutlinedButton(
        onPressed: () {
          WaitingDialog.show(
            context: context,
            future: _deleteAll(context),
            title: 'Deleting',
          );
        },
        child: Text('Delete all'),
      ),
    );
  }

  Future _deleteAll(BuildContext context) async {
    final database = GetIt.I.get<AppDatabase>();

    await database.clear();

    if (!context.mounted) {
      return;
    }

    context.read<ExplorerBloc>().add(ExplorerRefreshRequested());
  }
}
