import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/word/detail/cubit/word_detail_page_cubit.dart';
import 'package:open_words/shared/appbar/app_bar_title.dart';
import 'package:open_words/shared/constants/hero_tag_constants.dart';

class WordDetailTitle extends StatelessWidget {
  const WordDetailTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<WordDetailPageCubit>();

    return AppBarTitle(
      title: cubit.group.name,
      heroTag: HeroTagConstants.appbarTitleTag,
    );
  }
}
