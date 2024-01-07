import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/collection/readonly_list.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/view/mvvm/view_model.dart';
import 'package:open_words/service/navigation/material_navigator.dart';
import 'package:open_words/storage/word_group_storage.dart';
import 'package:open_words/view/word_group/detail/word_group_detail_page.dart';
import 'package:open_words/view/word_group/edit/word_group_create_page.dart';

class WordGroupListViewModel extends ViewModel {
  final WordGroupStorage _storage;

  late final List<WordGroup> _groups;
  late final IReadonlyList<WordGroup> groups;

  WordGroupListViewModel(this._storage);

  @override
  Future load() async {
    final all = await _storage.getAll();

    _groups = [];
    groups = ReadonlyList(_groups);

    _groups.addAll(all);
  }

  Future toDetail(BuildContext context, int index, UpdateState updateState) async {
    final result = await MaterialNavigator.push(
      context,
      (builder) => WordGroupDetailPage(
        group: _groups[index],
        heroIndex: index,
      ),
    );

    result.deleted<WordGroup>((value) {
      updateState(() {
        _groups.removeWhere((element) => element.id == value.id);
      });
    });

    result.modified<WordGroup>((value) {
      final index = _groups.indexWhere((element) => element.id == value.id);

      updateState(() {
        _groups[index] = value;
      });
    });
  }

  Future toCreate(BuildContext context, UpdateState updateState) async {
    final result = await MaterialNavigator.push(
      context,
      (builder) => const WordGroupCreatePage(),
    );

    result.created<WordGroup>((value) async {
      final updated = value.copyWith(index: _groups.length);

      await GetIt.I.get<WordGroupStorage>().set(updated.id, updated);

      updateState(() {
        _groups.add(updated);
      });
    });
  }
}
