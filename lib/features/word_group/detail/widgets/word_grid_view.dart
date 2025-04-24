import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/data/entities/word/word.dart';
import 'package:open_words/features/word/detail/word_detail_page.dart';
import 'package:open_words/features/word_group/detail/cubit/word_group_detail_cubit.dart';
import 'package:open_words/shared/constants/list_padding_constans.dart';
import 'package:open_words/shared/layout/adaptive_grid_view.dart';
import 'package:open_words/shared/navigation/material_navigator.dart';
import 'package:open_words/shared/tiles/word_tile.dart';

class WordGridView extends StatelessWidget {
  const WordGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final words = context.select(
          (WordGroupDetailCubit value) => value.state.words,
        );

        return AdaptiveGridView(
          maxCrossAxisExtent: 300,
          padding: const EdgeInsets.only(
            bottom: ListPaddingConstans.bottomForFab,
          ),
          itemCount: words.length,

          itemBuilder: (context, index) {
            final word = words[index];

            return WordTile(
              title: word.origin,
              subtitle: word.translation,
              onTap: () => _onTap(context, word),
            );
          },
        );
      },
    );
  }

  void _onTap(BuildContext context, Word word) async {
    final state = context.read<WordGroupDetailCubit>().state;

    await context.push(
      (context) => WordDetailPage(group: state.group, word: word),
    );
  }
}
