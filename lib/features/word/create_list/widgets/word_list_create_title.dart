import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/word/create_list/cubit/word_list_create_cubit.dart';
import 'package:open_words/shared/constants/hero_tag_constants.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

class WordListCreateTitle extends StatelessWidget {
  const WordListCreateTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: HeroTagConstants.appbarTitleTag,
      child: Text(
        context.read<WordListCreateCubit>().group.name,
        style: context.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: context.colorScheme.secondary,
        ),
      ),
    );
  }
}
