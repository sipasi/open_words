import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/word_metadata/update/cubit/word_metadata_update_cubit.dart';
import 'package:open_words/shared/navigation/material_navigator.dart';

class WordMetadataUpdateFab extends StatelessWidget {
  const WordMetadataUpdateFab({super.key});

  @override
  Widget build(BuildContext context) {
    final updateStatus = context.select(
      (WordMetadataUpdateCubit value) => value.state.updateStatus,
    );
    final progressText = context.select(
      (WordMetadataUpdateCubit value) => value.state.progressText,
    );

    return FloatingActionButton.extended(
      onPressed: () {
        if (updateStatus.isFinished) context.pop();
      },
      label: switch (updateStatus) {
        UpdateStatus.noInternet => Text('No Internet connection'),
        _ => Text(' $progressText'),
      },
      icon: switch (updateStatus.inProgress) {
        true => progressIndicator(),
        _ => Icon(Icons.done_all),
      },
    );
  }

  static Widget progressIndicator() {
    return const SizedBox(
      height: 24,
      width: 24,
      child: CircularProgressIndicator(),
    );
  }
}
