import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/explorer/_main_screen/bloc/explorer_bloc.dart';
import 'package:open_words/features/explorer/entity_editor/explorer_entity_editor.dart';
import 'package:open_words/shared/card/add_first_entity_card.dart';

class AddFirstFolderOrGroupCard extends StatelessWidget {
  const AddFirstFolderOrGroupCard({super.key});

  @override
  Widget build(BuildContext context) {
    final id = context.read<ExplorerBloc>().state.exploredId;

    return Center(
      child: AddFirstEntityCard(
        icon: Icons.create_new_folder_outlined,
        title: 'Tap to add your first folder or group',
        onTap: () {
          ExplorerEntityEditor.show(context: context, parentFolder: id);
        },
      ),
    );
  }
}
