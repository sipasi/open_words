import 'package:flutter/material.dart';
import 'package:open_words/features/database/widgets/database_summary/cubit/database_summary_cubit.dart';
import 'package:open_words/features/database/widgets/measure_cubit_tile.dart';

class AllEntityMeasureTile extends StatelessWidget {
  const AllEntityMeasureTile({super.key});

  @override
  Widget build(BuildContext context) {
    return MeasureCubitTile<DatabaseSummaryCubit>();
  }
}
