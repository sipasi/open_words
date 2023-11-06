import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/data/word/word_group.dart';
import 'package:open_words/service/navigation/material_navigator.dart';
import 'package:open_words/storage/word_group_storage.dart';
import 'package:open_words/view/shared/future_state.dart';
import 'package:open_words/view/shared/tile/hero_text_tile.dart';
import 'package:open_words/view/word_group/detail/word_group_detail_page.dart';
import 'package:open_words/view/word_group/edit/word_group_create_page.dart';

class WordGroupListPage extends StatefulWidget {
  const WordGroupListPage({super.key});

  @override
  State<WordGroupListPage> createState() => _WordGroupListPageState();
}

class _WordGroupListPageState extends FutureState<WordGroupListPage, List<WordGroup>> {
  @override
  Future<List<WordGroup>> getFuture() async {
    final storage = GetIt.I.get<WordGroupStorage>();

    final all = await storage.getAll();

    return all;
  }

  @override
  Widget successBuild(BuildContext context, List<WordGroup> data) {
    return _asGridView(context, data);
  }

  Widget _asGridView(BuildContext context, List<WordGroup> data) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.only(bottom: 120),
        childAspectRatio: 2.3,
        children: List.generate(
          data.length,
          (index) => HeroTextTile(
            title: data[index].name,
            subtitle: data[index].words.length.toString(),
            titleTag: 'WordGroupDetailTitle $index',
            subtitleTag: 'WordGroupDetailSubtitle $index',
            onTap: () async {
              final result = await MaterialNavigator.push(
                context,
                (builder) => WordGroupDetailPage(
                  group: data[index],
                  heroIndex: index,
                ),
              );

              result.deleted<WordGroup>((value) {
                setState(() {
                  cache?.removeWhere((element) => element.id == value.id);
                });
              });

              result.modified<WordGroup>((value) {
                final index = cache!.indexWhere((element) => element.id == value.id);

                setState(() {
                  cache![index] = value;
                });
              });
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final result = await MaterialNavigator.push(
            context,
            (builder) => const WordGroupCreatePage(),
          );

          result.created<WordGroup>((value) async {
            final updated = value.copyWith(index: cache!.length);

            await GetIt.I.get<WordGroupStorage>().set(updated.id, updated);

            setState(() {
              cache!.add(updated);
            });
          });
        },
      ),
    );
  }
}
