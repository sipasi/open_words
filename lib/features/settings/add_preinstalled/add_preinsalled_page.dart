import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/features/explorer/_main_screen/bloc/explorer_bloc.dart';
import 'package:open_words/features/settings/add_preinstalled/bloc/add_preinstalled_bloc.dart';
import 'package:open_words/features/settings/add_preinstalled/widgets/add_preinsalled_fab.dart';
import 'package:open_words/features/settings/add_preinstalled/widgets/add_preinsalled_list_view.dart';
import 'package:open_words/features/settings/add_preinstalled/widgets/constrained_center.dart';
import 'package:open_words/shared/modal/loading_dialog.dart';
import 'package:open_words/shared/navigation/material_navigator.dart';

class AddPreinsalledPage extends StatelessWidget {
  const AddPreinsalledPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddPreinstalledBloc(
        folderRepository: GetIt.I.get(),
        groupRepository: GetIt.I.get(),
        wordRepository: GetIt.I.get(),
      )..add(AddPreinstalledLoadRequested()),
      child: BlocListener<AddPreinstalledBloc, AddPreinstalledState>(
        listener: _listener,
        child: AddPreinsalledView(),
      ),
    );
  }

  void _listener(BuildContext context, AddPreinstalledState state) async {
    if (state.addToLibraryStatus.isAdding) {
      LoadingDialog.show(
        context: context,
        title: "Adding",
      );
      return;
    }

    if (state.addToLibraryStatus.isFinished) {
      await Future.delayed(Duration(milliseconds: 300));

      context
        ..read<ExplorerBloc>().add(ExplorerRefreshRequested())
        ..pop(times: 2);

      return;
    }
  }
}

class AddPreinsalledView extends StatelessWidget {
  const AddPreinsalledView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: AddPreinsalledFab(),
      body: ConstrainedCenter(
        child: AddPreinsalledListView(),
      ),
    );
  }
}
