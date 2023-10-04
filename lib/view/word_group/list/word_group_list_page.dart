import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/storage/work_group_storage.dart';
import 'package:open_words/view/shared/future_state.dart';
import 'package:open_words/view/shared/tile/custom_tile.dart';
import 'package:open_words/view/word_group/detail/word_group_detail_page.dart';

class WordGroupListPage extends StatefulWidget {
  const WordGroupListPage({super.key});

  @override
  State<WordGroupListPage> createState() => _WordGroupListPageState();
}

class _WordGroupListPageState
    extends FutureState<WordGroupListPage, List<WordGroup>> {
  @override
  Future<List<WordGroup>> getFuture() {
    final storage = GetIt.I.get<WorkGroupStorage>();

    return storage.getAll();
  }

  @override
  Widget successBuild(BuildContext context, List<WordGroup> data) {
    return _asGridView(context, data);
  }

  Widget _asGridView(BuildContext context, List<WordGroup> data) {
    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.zero,
      childAspectRatio: 2.3,
      children: List.generate(
        data.length,
        (index) => CustomTile(
          title: data[index].name,
          subtitle: data[index].words.length.toString(),
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (builder) => WordGroupDetailPage(group: data[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}
