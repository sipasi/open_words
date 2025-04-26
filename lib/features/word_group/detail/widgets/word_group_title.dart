import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/word_group/detail/cubit/word_group_detail_cubit.dart';
import 'package:open_words/shared/appbar/app_bar_title.dart';
import 'package:open_words/shared/constants/hero_tag_constants.dart';

class WordGroupTitle extends StatelessWidget {
  const WordGroupTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final name = context.select(
      (WordGroupDetailCubit value) => value.state.group.name,
    );

    return AppBarTitle(title: name, heroTag: HeroTagConstants.appbarTitleTag);
  }
}
