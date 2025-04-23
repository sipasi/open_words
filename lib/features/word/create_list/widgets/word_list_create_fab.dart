import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/word/create_list/cubit/word_list_create_cubit.dart';
import 'package:open_words/shared/constants/hero_tag_constants.dart';

class WordListCreateFab extends StatelessWidget {
  const WordListCreateFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: HeroTagConstants.fabDefaultTag,
      onPressed: () => _onAdd(context),
      label: Text('Add'),
      icon: Icon(Icons.add),
    );
  }

  void _onAdd(BuildContext context) {
    final cubit = context.read<WordListCreateCubit>();

    cubit.addDraft();
  }
}
