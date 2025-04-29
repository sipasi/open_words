import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/data/draft/metadata/phonetic_draft.dart';
import 'package:open_words/core/data/entities/metadata/phonetic.dart';
import 'package:open_words/core/result/result.dart';
import 'package:open_words/features/word/edit/bloc/word_edit_bloc.dart';
import 'package:open_words/features/word_metadata/editor_phonetic/cubit/editor_phonetic_cubit.dart';
import 'package:open_words/features/word_metadata/editor_phonetic/widgets/editor_phonetic_view.dart';
import 'package:open_words/shared/navigation/material_navigator.dart';

class EditorPhoneticBottomSheet {
  static AsyncResult<PhoneticDraft> create({required BuildContext context}) {
    return context.pushSmoothSheet((context) {
      return BlocProvider(
        create: (context) => EditorPhoneticCubit(),
        child: EditorPhoneticView(),
      );
    });
  }

  static AsyncResult<PhoneticDraft> edit({
    required BuildContext context,
    required Phonetic phonetic,
  }) {
    return context.pushSmoothSheetBloc(context.read<WordEditBloc>(), (context) {
      return BlocProvider(
        create: (context) => EditorPhoneticCubit(initial: phonetic),
        child: EditorPhoneticView(),
      );
    });
  }
}
