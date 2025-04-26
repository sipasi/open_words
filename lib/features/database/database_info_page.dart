import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/core/data/sources/app_database.dart';
import 'package:open_words/features/database/widgets/database_add/add_test_entity_tile.dart';
import 'package:open_words/features/database/widgets/database_add/cubit/database_add_cubit.dart';
import 'package:open_words/features/database/widgets/database_repository_test/explorer/cubit/explorer_test_cubit.dart';
import 'package:open_words/features/database/widgets/database_repository_test/explorer/explorer_test_tile.dart';
import 'package:open_words/features/database/widgets/database_repository_test/folder/cubit/folder_repository_test_cubit.dart';
import 'package:open_words/features/database/widgets/database_repository_test/folder/folder_repository_test_tile.dart';
import 'package:open_words/features/database/widgets/database_repository_test/groups/cubit/group_repository_test_cubit.dart';
import 'package:open_words/features/database/widgets/database_repository_test/groups/group_repository_test_tile.dart';
import 'package:open_words/features/database/widgets/database_repository_test/words/cubit/word_repository_test_cubit.dart';
import 'package:open_words/features/database/widgets/database_repository_test/words/word_repository_test_tile.dart';
import 'package:open_words/features/database/widgets/database_summary/all_entity_measure_tile.dart';
import 'package:open_words/features/database/widgets/database_summary/cubit/database_summary_cubit.dart';
import 'package:open_words/shared/constants/list_padding_constans.dart';

class DatabaseInfoPage extends StatelessWidget {
  const DatabaseInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final database = (GetIt.I.get<AppDatabase>() as AppDatabaseImpl).database;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DatabaseAddCubit(database)),
        BlocProvider(
          create: (context) => DatabaseSummaryCubit(database)..init(),
        ),
        BlocProvider(
          create:
              (context) =>
                  GroupRepositoryTestCubit(database, GetIt.I.get())..init(),
        ),
        BlocProvider(
          create:
              (context) =>
                  WordRepositoryTestCubit(database, GetIt.I.get())..init(),
        ),
        BlocProvider(
          create:
              (context) =>
                  FolderRepositoryTestCubit(database, GetIt.I.get())..init(),
        ),
        BlocProvider(
          create:
              (context) => ExplorerTestCubit(database, GetIt.I.get())..init(),
        ),
      ],
      child: DatabaseInfoView(),
    );
  }
}

class DatabaseInfoView extends StatelessWidget {
  const DatabaseInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.only(
          bottom: ListPaddingConstans.bottomForFab,
        ),
        children: [
          AddTestEntityTile(),
          AllEntityMeasureTile(),
          GroupRepositoryTestTile(),
          WordRepositoryTestTile(),
          FolderRepositoryTestTile(),
          ExplorerTestTile(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _onReload(context),
        label: Text('reload'),
        icon: Icon(Icons.timer_outlined),
      ),
    );
  }

  void _onReload(BuildContext context) {
    context.read<DatabaseSummaryCubit>().measure();
  }
}
