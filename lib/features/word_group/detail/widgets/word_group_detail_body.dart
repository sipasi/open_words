import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/word_group/detail/cubit/word_group_detail_cubit.dart';
import 'package:open_words/features/word_group/detail/widgets/add_first_words_view.dart';
import 'package:open_words/features/word_group/detail/widgets/word_grid_view.dart';

class WordGroupDetailBody extends StatelessWidget {
  const WordGroupDetailBody({super.key});

  @override
  Widget build(BuildContext context) {
    final words = context.select(
      (WordGroupDetailCubit value) => value.state.words,
    );

    if (words.isEmpty) {
      return AddFirstWordsView();
    }

    return WordGridView(words: words);
  }
}
