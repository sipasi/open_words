import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/settings_import_export/export_selection/bloc/export_selection_cubit.dart';
import 'package:open_words/shared/layout/adaptive_grid_view.dart';
import 'package:open_words/shared/theme/theme_extension.dart';

class ExportSelectionListView extends StatelessWidget {
  const ExportSelectionListView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ExportSelectionCubit>();

    final state = bloc.state;

    return AdaptiveGridView(
      itemCount: state.groups.length,
      maxCrossAxisExtent: 300,
      itemBuilder: (context, index) {
        final group = state.groups[index];
        final selected = state.selected.contains(group);

        return Card.outlined(
          color: selected ? context.colorScheme.secondaryContainer : null,
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () => bloc.toggle(group),
            splashColor: context.colorScheme.primary.withAlpha(80),
            hoverColor: context.colorScheme.primary.withAlpha(40),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 10,
              ),
              child: Text(
                group.name,
                style: TextStyle(
                  color: context.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
