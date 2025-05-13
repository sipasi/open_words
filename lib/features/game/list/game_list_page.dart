import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/data/entities/word/word.dart';
import 'package:open_words/core/data/entities/word/word_group.dart';
import 'package:open_words/features/game/list/cubit/game_list_cubit.dart';
import 'package:open_words/features/game/list/widgets/game_list_body_view.dart';
import 'package:open_words/features/game/list/widgets/game_list_bottom_bar.dart';
import 'package:open_words/shared/appbar/app_bar_title.dart';
import 'package:open_words/shared/constants/hero_tag_constants.dart';

class GameListPage extends StatelessWidget {
  final WordGroup group;
  final List<Word> words;

  const GameListPage({super.key, required this.group, required this.words});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => GameListCubit(
            groupName: group.name,
            origin: group.origin,
            translation: group.translation,
            words: words,
            minWordCountUpperLimit: 8,
          )..init(),
      child: GameListView(),
    );
  }
}

class GameListView extends StatelessWidget {
  const GameListView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<GameListCubit>();

    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(
          heroTag: HeroTagConstants.appbarTitleTag,
          title: bloc.groupName,
        ),
      ),
      body: GameListBodyView(),
      bottomSheet: GameListBottomBar(),
    );
  }
}
