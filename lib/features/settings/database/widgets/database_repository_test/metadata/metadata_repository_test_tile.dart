import 'package:flutter/material.dart';
import 'package:open_words/features/settings/database/widgets/database_repository_test/metadata/cubit/metadata_repository_test_cubit.dart';
import 'package:open_words/features/settings/database/widgets/measure_cubit_tile.dart';

class MetadataRepositoryTestTile extends StatelessWidget {
  const MetadataRepositoryTestTile({super.key});

  @override
  Widget build(BuildContext context) {
    return MeasureCubitTile<MetadataRepositoryTestCubit>();
  }
}
