import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/settings/database/widgets/database_add/cubit/database_add_cubit.dart';
import 'package:open_words/features/settings/database/widgets/database_summary/cubit/database_summary_cubit.dart';
import 'package:open_words/features/settings/database/widgets/measure_tile.dart';
import 'package:open_words/features/settings/database/widgets/selection_times_tile.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AddTestEntityTile extends StatelessWidget {
  const AddTestEntityTile({super.key});

  @override
  Widget build(BuildContext context) {
    final summaryCubit = context.read<DatabaseSummaryCubit>();
    final cubit = context.watch<DatabaseAddCubit>();

    final loading = cubit.state.loading;
    final measure = cubit.state.measure;

    return Skeletonizer(
      enabled: loading,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SelectionTimesTile.simple(
              title: 'Add Folder',
              onTimes: (value) =>
                  cubit.addFloder(value).then((_) => summaryCubit.measure()),
            ),

            SelectionTimesTile(
              title: 'Add Group with Words',
              pattern: [0, 10, 100, 1000, 1000 * 10],
              onTimes: (value) =>
                  cubit.addWords(value).then((_) => summaryCubit.measure()),
            ),
            MeasureTile(title: 'Elapsed', measure: measure),
          ],
        ),
      ),
    );
  }
}
