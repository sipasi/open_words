import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/word/create_list/word_list_create_page.dart';
import 'package:open_words/features/word_group/detail/cubit/word_group_detail_cubit.dart';
import 'package:open_words/shared/card/add_first_entity_card.dart';
import 'package:open_words/shared/navigation/material_navigator.dart';

class AddFirstWordsView extends StatelessWidget {
  const AddFirstWordsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AddFirstEntityCard(
        icon: Icons.menu_book_outlined,
        title: 'Tap to add your first words',
        onTap: () async {
          final bloc = context.read<WordGroupDetailCubit>();

          await context.push(
            (context) => WordListCreatePage(group: bloc.state.group),
          );

          await bloc.init();
        },
      ),
    );
  }
}
