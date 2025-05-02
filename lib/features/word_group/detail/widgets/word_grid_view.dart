import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/data/entities/id.dart';
import 'package:open_words/core/data/entities/word/word.dart';
import 'package:open_words/core/result/result.dart';
import 'package:open_words/features/word/detail/word_detail_page.dart';
import 'package:open_words/features/word_group/detail/cubit/word_group_detail_cubit.dart';
import 'package:open_words/shared/constants/list_padding_constans.dart';
import 'package:open_words/shared/layout/adaptive_grid_view.dart';
import 'package:open_words/shared/layout/extensions/list_padding_extension.dart';
import 'package:open_words/shared/navigation/material_navigator.dart';
import 'package:open_words/shared/tiles/word_tile.dart';

class WordGridView extends StatelessWidget {
  final List<Word> words;

  const WordGridView({super.key, required this.words});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return AdaptiveGridView(
          maxCrossAxisExtent: 300,
          padding: context.safeListViewPadding(
            extraBottom: ListPaddingConstans.bottomForFab,
          ),
          itemCount: words.length,

          itemBuilder: (context, index) {
            final word = words[index];

            return WordTile(
              title: word.origin,
              subtitle: word.translation,
              onTap: () => _onTap(context, word, index),
            );
          },
        );
      },
    );
  }

  void _onTap(BuildContext context, Word word, int index) async {
    final bloc = context.read<WordGroupDetailCubit>();

    final state = bloc.state;

    final result = await context.push(
      (context) => WordDetailPage(group: state.group, word: word),
    );

    result.onDeleted((value) {
      if (value is! Id) {
        return;
      }

      bloc.deleteAt(value, index);
    });
  }
}
