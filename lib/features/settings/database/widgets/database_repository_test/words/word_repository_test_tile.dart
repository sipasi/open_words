import 'package:flutter/material.dart';
import 'package:open_words/features/settings/database/widgets/database_repository_test/words/cubit/word_repository_test_cubit.dart';
import 'package:open_words/features/settings/database/widgets/measure_cubit_tile.dart';

class WordRepositoryTestTile extends StatelessWidget {
  const WordRepositoryTestTile({super.key});

  @override
  Widget build(BuildContext context) {
    return MeasureCubitTile<WordRepositoryTestCubit>();
  }
}
