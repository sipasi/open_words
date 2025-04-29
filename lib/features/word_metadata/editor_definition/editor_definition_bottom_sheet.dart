import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/data/entities/id.dart';
import 'package:open_words/core/data/entities/metadata/definition.dart';
import 'package:open_words/core/result/result.dart';
import 'package:open_words/features/word_metadata/editor_definition/cubit/editor_definition_cubit.dart';
import 'package:open_words/features/word_metadata/editor_definition/widgets/editor_definition_view.dart';
import 'package:open_words/shared/navigation/material_navigator.dart';

class EditorDefinitionBottomSheet {
  static AsyncResult<Definition> create({
    required BuildContext context,
    required Id meaningId,
  }) {
    return context.pushSmoothSheet((context) {
      return BlocProvider(
        create: (context) => EditorDefinitionCubit(meaningId: meaningId),
        child: EditorDefinitionView(),
      );
    });
  }

  static AsyncResult<Definition> edit({
    required BuildContext context,
    required Definition definition,
  }) {
    return context.pushSmoothSheet((context) {
      return BlocProvider(
        create:
            (context) => EditorDefinitionCubit(
              meaningId: definition.meaningId,
              initial: definition,
            ),
        child: EditorDefinitionView(),
      );
    });
  }
}
