import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/word/create_list/cubit/word_list_create_cubit.dart';
import 'package:open_words/features/word/create_list/widgets/word_draft_tile.dart';

class WordDraftListView extends StatelessWidget {
  const WordDraftListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WordListCreateCubit, WordListCreateState>(
      builder: (context, state) {
        final drafts = state.drafts;

        return Column(
          children: List.generate(drafts.length, (index) {
            return WordDraftTile(
              key: ValueKey(drafts[index]),
              draft: drafts[index],
              onRemoveTap: () => _onDraftRemove(context, index),
            );
          }),
        );
      },
    );
  }

  void _onDraftRemove(BuildContext context, int index) {
    context.read<WordListCreateCubit>().removeDraft(index);
  }
}
