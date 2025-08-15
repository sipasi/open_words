import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/core/data/entities/word/word_group.dart';
import 'package:open_words/core/services/vibration/vibration_service.dart';
import 'package:open_words/features/explorer/_main_screen/bloc/explorer_bloc.dart';
import 'package:open_words/features/explorer/_main_screen/widgets/explorer_grid_tile.dart';
import 'package:open_words/features/explorer/entity_editor/explorer_entity_editor.dart';
import 'package:open_words/features/explorer/entity_editor/models/explorer_entity_union.dart';
import 'package:open_words/features/word_group/detail/word_group_detail_page.dart';
import 'package:open_words/shared/navigation/material_navigator.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

class GroupTile extends StatelessWidget {
  final WordGroup group;

  const GroupTile({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return ExplorerGridTile(
      title: group.name,
      titleStyle: TextStyle(color: colorScheme.primary),
      trailing: Text(group.words.toString()),
      icon: Icon(Icons.book_outlined, color: colorScheme.primary),
      iconBackground: colorScheme.secondaryContainer,
      onTap: () => onTap(context, group),
      onLongPress: () => onLongPress(context, group),
    );
  }

  Future onTap(BuildContext context, WordGroup value) {
    return context.push((context) => WordGroupDetailPage(group: group));
  }

  Future onLongPress(BuildContext context, WordGroup value) {
    GetIt.I.get<VibrationService>().tap();

    return ExplorerEntityEditor.show(
      context: context,
      parentFolder: context.read<ExplorerBloc>().state.exploredId,
      entityUnion: ExplorerEntityUnion.group(value),
    );
  }
}
