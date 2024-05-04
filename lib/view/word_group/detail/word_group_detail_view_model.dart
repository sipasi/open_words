import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/data/word/word.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/service/navigation/material_navigator.dart';
import 'package:open_words/service/result.dart';
import 'package:open_words/storage/word_group_storage.dart';
import 'package:open_words/view/game/game_list_page.dart';
import 'package:open_words/view/mvvm/view_model.dart';
import 'package:open_words/view/shared/dialog/delete_dialog.dart';
import 'package:open_words/view/word/create/word_list_create_page.dart';
import 'package:open_words/view/word/detail/word_detail_page.dart';
import 'package:open_words/view/word_group/edit/word_group_edit_page.dart';

class WordGroupDetailViewModel {
  WordGroup _group;

  String get name => _group.name;

  int get length => _group.words.length;

  WordGroupDetailViewModel(this._group);

  Word wordBy(int index) => _group.words[index];

  void navigateBack(BuildContext context) {
    MaterialNavigator.popWith(context, CrudResult.modify(_group));
  }

  Future navigateToGames(BuildContext context) {
    return MaterialNavigator.push(
      context,
      (buider) => GameListPage(group: _group),
    );
  }

  Future tryDelete(BuildContext context) async {
    bool result = await DeleteDialog.show(context: context);

    if (result == false) {
      return;
    }

    await GetIt.I.get<WordGroupStorage>().delete(_group.id);

    if (context.mounted) MaterialNavigator.popWith(context, CrudResult.delete(_group));
  }

  Future tryEdit(BuildContext context, UpdateState updateState) async {
    final result = await MaterialNavigator.push<WordGroup>(
      context,
      (builder) => WordGroupEditPage(group: _group),
    );

    result.modified<WordGroup>((value) async {
      updateState(() {
        _group = value;
      });

      await GetIt.I.get<WordGroupStorage>().set(value.id, value);
    });
  }

  Future tryAddWords(BuildContext context, UpdateState updateState) async {
    final result = await MaterialNavigator.push(
      context,
      (context) => WordListCreatePage(
        name: _group.name,
        origin: _group.origin,
        translation: _group.translation,
        startIndex: _group.words.length,
      ),
    );

    result.created<List<Word>>((list) async {
      if (list.isEmpty) {
        return;
      }

      updateState(() {
        _group.words.addAll(list);
      });

      await GetIt.I.get<WordGroupStorage>().set(_group.id, _group);
    });
  }

  Future onTap(BuildContext context, UpdateState updateState, int index) async {
    final result = await MaterialNavigator.push(
      context,
      (builder) => WordDetailPage(
        groupId: _group.id,
        wordId: index,
        word: _group.words[index],
        originLanguage: _group.origin,
        translationLanguage: _group.translation,
      ),
    );

    result.modified<Word>((word) async {
      updateState(() {
        _group.words[index] = word;
      });
    });

    result.deleted<Word>((_) async {
      updateState(() {
        _group.words.removeAt(index);
      });
    });
  }
}
