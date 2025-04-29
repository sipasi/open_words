import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/word/edit/bloc/word_edit_bloc.dart';
import 'package:open_words/shared/appbar/app_bar_title.dart';

class WordEditTitle extends StatelessWidget {
  const WordEditTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBarTitle(title: context.read<WordEditBloc>().initialOrigin);
  }
}
