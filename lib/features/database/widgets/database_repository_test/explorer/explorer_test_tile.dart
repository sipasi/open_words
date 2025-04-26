import 'package:flutter/material.dart';
import 'package:open_words/features/database/widgets/database_repository_test/explorer/cubit/explorer_test_cubit.dart';
import 'package:open_words/features/database/widgets/measure_cubit_tile.dart';

class ExplorerTestTile extends StatelessWidget {
  const ExplorerTestTile({super.key});

  @override
  Widget build(BuildContext context) {
    return MeasureCubitTile<ExplorerTestCubit>();
  }
}
