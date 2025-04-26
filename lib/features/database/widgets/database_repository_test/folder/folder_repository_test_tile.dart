import 'package:flutter/material.dart';
import 'package:open_words/features/database/widgets/database_repository_test/folder/cubit/folder_repository_test_cubit.dart';
import 'package:open_words/features/database/widgets/measure_cubit_tile.dart';

class FolderRepositoryTestTile extends StatelessWidget {
  const FolderRepositoryTestTile({super.key});

  @override
  Widget build(BuildContext context) {
    return MeasureCubitTile<FolderRepositoryTestCubit>();
  }
}
