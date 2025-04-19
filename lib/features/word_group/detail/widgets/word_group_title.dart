import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/word_group/detail/cubit/word_group_detail_cubit.dart';

class WordGroupTitle extends StatelessWidget {
  const WordGroupTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final name = context.select(
          (WordGroupDetailCubit value) => value.state.name,
        );
    
        return Text(name);
      },
    );
  }
}
