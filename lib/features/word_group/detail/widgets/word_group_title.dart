import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/word_group/detail/cubit/word_group_detail_cubit.dart';
import 'package:open_words/shared/constants/hero_tag_constants.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

class WordGroupTitle extends StatelessWidget {
  const WordGroupTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final name = context.select(
          (WordGroupDetailCubit value) => value.state.group.name,
        );

        return Hero(
          tag: HeroTagConstants.appbarTitleTag,
          child: Text(
            name,
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colorScheme.secondary,
            ),
          ),
        );
      },
    );
  }
}
