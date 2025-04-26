import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/word/create_list/cubit/word_list_create_cubit.dart';
import 'package:open_words/shared/appbar/app_bar_title.dart';
import 'package:open_words/shared/constants/hero_tag_constants.dart';

class WordListCreateTitle extends StatelessWidget {
  const WordListCreateTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBarTitle(
      title: context.read<WordListCreateCubit>().group.name,
      heroTag: HeroTagConstants.appbarTitleTag,
    );
  }
}
