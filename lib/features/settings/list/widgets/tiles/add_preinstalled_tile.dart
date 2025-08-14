import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/core/data/draft/word_draft.dart';
import 'package:open_words/core/data/entities/id.dart';
import 'package:open_words/core/data/entities/language_info.dart';
import 'package:open_words/core/data/repository/folder_repository.dart';
import 'package:open_words/core/data/repository/word_group_repository.dart';
import 'package:open_words/core/data/repository/word_repository.dart';
import 'package:open_words/core/generated/assets/assets.gen.dart';
import 'package:open_words/features/explorer/list/bloc/explorer_bloc.dart';
import 'package:open_words/features/settings/list/widgets/settings_tile_button.dart';
import 'package:open_words/shared/modal/waiting_dialog.dart';

class AddPreinstalledTile extends StatelessWidget {
  const AddPreinstalledTile({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsTileButton(
      title: 'Add preinstalled',
      icon: Icons.install_desktop,
      onTap: () {
        WaitingDialog.show(
          context: context,
          future: _addPreinstalled(context),
          title: 'Adding',
        );
      },
    );
  }

  Future _addPreinstalled(BuildContext context) async {
    final folderRepository = GetIt.I.get<FolderRepository>();
    final groupRepository = GetIt.I.get<WordGroupRepository>();
    final wordRepository = GetIt.I.get<WordRepository>();

    final jsonData = await rootBundle.loadString(
      Assets.json.dictionary.ukrainian.common,
    );

    final jsonResult = jsonDecode(jsonData);

    final folderName = 'Open Words Collection';

    final folder =
        await folderRepository.oneByName(folderName) ??
        await folderRepository.create(
          parentId: const Id.empty(),
          name: folderName,
        );

    for (var node in jsonResult) {
      final group = await groupRepository.create(
        folderId: folder.id,
        name: node['name'],
        origin: LanguageInfo.fromMap(node['origin']),
        translation: LanguageInfo.fromMap(node['translation']),
      );

      await wordRepository.createAll(
        groupId: group.id,
        drafts: List.of(node['words']).map((e) {
          return WordDraft(
            origin: e['origin'],
            translation: e['translation'],
          );
        }).toList(),
      );
    }

    if (!context.mounted) {
      return;
    }

    context.read<ExplorerBloc>().add(ExplorerRefreshRequested());
  }
}
