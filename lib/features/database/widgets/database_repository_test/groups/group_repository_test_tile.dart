import 'package:flutter/material.dart';
import 'package:open_words/features/database/widgets/database_repository_test/groups/cubit/group_repository_test_cubit.dart';
import 'package:open_words/features/database/widgets/measure_cubit_tile.dart';

class GroupRepositoryTestTile extends StatelessWidget {
  const GroupRepositoryTestTile({super.key});

  @override
  Widget build(BuildContext context) {
    return MeasureCubitTile<GroupRepositoryTestCubit>();
  }
}
