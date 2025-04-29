import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/word/edit/bloc/word_edit_bloc.dart';
import 'package:open_words/shared/constants/hero_tag_constants.dart';

class WordEditFab extends StatelessWidget {
  const WordEditFab({super.key});

  @override
  Widget build(BuildContext context) {
    final isEmpty = context.select(
      (WordEditBloc bloc) => bloc.state.translation.isEmpty,
    );

    return FloatingActionButton.extended(
      heroTag: HeroTagConstants.fabDefaultTag,
      onPressed:
          isEmpty
              ? null
              : () {
                context.read<WordEditBloc>().add(WordEditSaveRequested());
              },
      icon: Icon(Icons.save_outlined),
      label: Text('Save'),
    );
  }
}
