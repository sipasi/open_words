import 'package:flutter/material.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/service/result.dart';
import 'package:open_words/view/mvvm/view_model.dart';
import 'package:open_words/service/navigation/material_navigator.dart';
import 'package:open_words/storage/word_group_storage.dart';
import 'package:open_words/view/word_group/detail/word_group_detail_page.dart';
import 'package:open_words/view/word_group/edit/word_group_create_page.dart';

class WordGroupListViewModel extends ViewModel {
  final WordGroupStorage _storage;

  late final List<WordGroup> groups;

  WordGroupListViewModel(this._storage);

  @override
  Future load() async => groups = await _storage.getAll();

  Future toDetail(BuildContext context, int index, UpdateState updateState) async {
    final result = await MaterialNavigator.push(
      context,
      (builder) => WordGroupDetailPage(
        group: groups[index],
        heroIndex: index,
      ),
    );

    result.deleted<WordGroup>((value) {
      updateState(() {
        groups.removeWhere((element) => element.id == value.id);
      });
    });

    result.modified<WordGroup>((value) {
      final index = groups.indexWhere((element) => element.id == value.id);

      updateState(() {
        groups[index] = value;
      });
    });
  }

  Future toCreate(BuildContext context, UpdateState updateState) async {
    final result = await MaterialNavigator.push(
      context,
      (builder) => const WordGroupCreatePage(),
    );

    result.created<WordGroup>((value) {
      updateState(() {
        groups.add(value);
      });
    });
  }
}
