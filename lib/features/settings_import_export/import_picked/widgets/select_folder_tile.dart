import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/core/data/repository/folder_repository.dart';
import 'package:open_words/features/settings_import_export/import_picked/cubit/import_picked_cubit.dart';
import 'package:open_words/shared/builders/value_builder_extension.dart';
import 'package:open_words/shared/modal/folder_list_modal.dart';

class SelectFolderTile extends StatelessWidget {
  const SelectFolderTile({super.key});

  @override
  Widget build(BuildContext context) {
    final folderPath = context.select(
      (ImportPickedCubit value) => value.state.folderPath,
    );

    return ListTile(
      title: folderPath.valueBuilderOr(
        when: (value) => true,
        builder: (value) => Text(value.name),
        or: () => Text('Root folder'),
      ),
      subtitle: folderPath.valueBuilderOr(
        when: (value) => true,
        builder: (value) => Text(value.path),
        or: () => Text('/'),
      ),
      onTap: () async {
        final allPath = await GetIt.I.get<FolderRepository>().allPath();

        if (!context.mounted) {
          return;
        }

        final path = await FolderListModal.dialog(
          context: context,
          current: folderPath,
          values: allPath,
        );

        if (!context.mounted || path == null) {
          return;
        }

        context.read<ImportPickedCubit>().setPath(path);
      },
    );
  }
}
