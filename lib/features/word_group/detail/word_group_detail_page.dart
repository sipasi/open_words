import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/core/data/entities/word/word_group.dart';
import 'package:open_words/features/word_group/detail/cubit/word_group_detail_cubit.dart';
import 'package:open_words/features/word_group/detail/widgets/word_grid_view.dart';
import 'package:open_words/features/word_group/detail/widgets/word_group_detail_fab.dart';
import 'package:open_words/features/word_group/detail/widgets/word_group_title.dart';

class WordGroupDetailPage extends StatelessWidget {
  final WordGroup group;

  const WordGroupDetailPage({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => WordGroupDetailCubit(
            group: group,
            wordRepository: GetIt.I.get(),
            groupRepository: GetIt.I.get(),
          )..init(),
      child: WordGroupDetailView(),
    );
  }
}

class WordGroupDetailView extends StatelessWidget {
  const WordGroupDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: WordGroupTitle()),
      body: WordGridView(),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: WordGroupDetailFab(),
    );
  }
}
