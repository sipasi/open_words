import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/settings/add_preinstalled/bloc/add_preinstalled_bloc.dart';

class AddPreinsalledFab extends StatelessWidget {
  const AddPreinsalledFab({super.key});

  @override
  Widget build(BuildContext context) {
    final isEmpty = context.select(
      (AddPreinstalledBloc value) => value.state.selected.isEmpty,
    );

    if (isEmpty) {
      return const SizedBox.shrink();
    }

    return FloatingActionButton.extended(
      onPressed: () => _onPressed(context),
      icon: Icon(Icons.library_add_check_outlined),
      label: Text('Add to library'),
    );
  }

  void _onPressed(BuildContext context) {
    context.read<AddPreinstalledBloc>().add(
      AddPreinstalledAddToLibraryRequested(),
    );
  }
}
