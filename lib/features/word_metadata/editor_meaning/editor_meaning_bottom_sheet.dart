import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/data/entities/id.dart';
import 'package:open_words/core/data/entities/metadata/meaning.dart';
import 'package:open_words/core/result/result.dart';
import 'package:open_words/features/word_metadata/editor_meaning/cubit/editor_meaning_cubit.dart';
import 'package:open_words/features/word_metadata/editor_meaning/widgets/editor_meaning_view.dart';
import 'package:open_words/shared/navigation/material_navigator.dart';

class EditorMeaningBottomSheet {
  static AsyncResult<Meaning> create({
    required BuildContext context,
    required Id metadataId,
  }) {
    return context.pushSmoothSheet((context) {
      return BlocProvider(
        create: (context) => EditorMeaningCubit(metadataId: metadataId),
        child: EditorMeaningView(),
      );
    });
  }

  static AsyncResult<Meaning> edit({
    required BuildContext context,
    required Id metadataId,
    required Meaning meaning,
  }) {
    return context.pushSmoothSheet((context) {
      return BlocProvider(
        create:
            (context) =>
                EditorMeaningCubit(metadataId: metadataId, initial: meaning),
        child: EditorMeaningView(),
      );
    });
  }
}
