import 'dart:convert';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:open_words/collection/readonly_list.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/service/navigation/material_navigator.dart';
import 'package:open_words/storage/word_group_storage.dart';
import 'package:open_words/view/mvvm/view_model.dart';
import 'package:open_words/view/shared/scaffold/selectable_words_view_model.dart';
import 'package:uuid/v4.dart';

class ImportViewModel extends ViewModel {
  late SelectableWordsViewModel selectable;

  final WordGroupStorage storage;

  ImportViewModel(this.storage);

  @override
  Future load() async {
    final files = await openFiles(acceptedTypeGroups: [
      const XTypeGroup(
        label: 'text',
        extensions: ['json', 'json'],
      )
    ]);

    List<WordGroup> groups = [];

    for (var file in files) {
      final text = await file.readAsString();

      final decoded = json.decode(
        text,
        reviver: (key, value) => value,
      );

      if (decoded is List<dynamic>) {
        final result = decoded.map((item) => WordGroup.fromJson(item));

        groups.addAll(result);
      }
    }

    selectable = SelectableWordsViewModel(groups.asReadonly());
  }

  Future onImport(BuildContext context) async {
    for (var i = 0; i < selectable.groups.length; i++) {
      final group = selectable.groups[i].copyWith(
        id: const UuidV4().generate(),
      );

      await storage.set(group.id, group);
    }

    MaterialNavigator.pop(context);
  }
}
