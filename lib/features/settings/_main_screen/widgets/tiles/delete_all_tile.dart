import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/core/data/sources/app_database.dart';
import 'package:open_words/features/explorer/_main_screen/bloc/explorer_bloc.dart';
import 'package:open_words/features/settings/_main_screen/widgets/settings_tile_button.dart';
import 'package:open_words/shared/modal/waiting_dialog.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

class DeleteAllTile extends StatelessWidget {
  const DeleteAllTile({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsTileButton(
      title: 'Delete all',
      icon: Icons.delete_forever_outlined,
      onTap: () async {
        final delete = await _showWarning(context);

        if (context.mounted && delete) {
          WaitingDialog.show(
            context: context,
            future: _deleteAll(context),
            title: 'Deliting',
          );
        }
      },
    );
  }

  Future<bool> _showWarning(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete All Data'),
        content: Text(
          'This action will permanently delete all your data. It cannot be undone.',
        ),
        actions: [
          TextButton.icon(
            label: Text(
              'Delete',
              style: TextStyle(color: context.colorScheme.error),
            ),
            icon: Icon(
              Icons.delete_forever_outlined,
              color: context.colorScheme.error,
            ),
            onPressed: () => Navigator.pop(context, true),
          ),
          FilledButton(
            child: Text('No'),
            onPressed: () => Navigator.pop(context, false),
          ),
        ],
      ),
    );

    return result ?? false;
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
