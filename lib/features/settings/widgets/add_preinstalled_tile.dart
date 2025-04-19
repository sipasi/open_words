import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/core/data/entities/id.dart';
import 'package:open_words/core/data/entities/language_info.dart';
import 'package:open_words/core/data/repository/word_group_repository.dart';
import 'package:open_words/core/data/repository/word_repository.dart';
import 'package:open_words/features/explorer/bloc/explorer_bloc.dart';
import 'package:open_words/shared/modal/waiting_dialog.dart';

class AddPreinstalledTile extends StatelessWidget {
  const AddPreinstalledTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.install_desktop),
      title: OutlinedButton(
        onPressed: () {
          WaitingDialog.show(
            context: context,
            future: _addPreinstalled(context),
            title: 'Adding',
          );
        },
        child: Text('Add preinstalled'),
      ),
    );
  }

  Future _addPreinstalled(BuildContext context) async {
    final groupRepository = GetIt.I.get<WordGroupRepository>();
    final wordRepository = GetIt.I.get<WordRepository>();

    final jsonData = await rootBundle.loadString(
      'assets/json/build_in_dictionaries.json',
    );

    final jsonResult = jsonDecode(jsonData);

    for (var node in jsonResult) {
      final group = await groupRepository.create(
        parentFolder: const Id.empty(),
        name: node['name'],
        origin: LanguageInfo.fromMap(node['origin']),
        translation: LanguageInfo.fromMap(node['translation']),
      );

      for (var wordNode in node['words']) {
        await wordRepository.create(
          group: group.id,
          origin: wordNode['origin'],
          translation: wordNode['translation'],
        );
      }
    }

    if (!context.mounted) {
      return;
    }

    context.read<ExplorerBloc>().add(ExplorerLoadRequested());
  }
}
