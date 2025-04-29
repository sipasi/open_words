import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/word/detail/cubit/word_detail_page_cubit.dart';
import 'package:open_words/features/word/detail/widgets/metadata_not_found_view.dart';
import 'package:open_words/features/word_metadata/detail/word_metadata_view.dart';
import 'package:open_words/features/word_metadata/loading/word_metadata_loading_view.dart';

class WordDetailMetadataView extends StatelessWidget {
  const WordDetailMetadataView({super.key});

  @override
  Widget build(BuildContext context) {
    final loadStatus = context.select(
      (WordDetailPageCubit value) => value.state.metadataLoadStatus,
    );
    final cubit = context.read<WordDetailPageCubit>();

    if (loadStatus.isLoading) {
      return WordMetadataLoadingView();
    }
    if (loadStatus.isLookupBefore || loadStatus.isFailure) {
      return MetadataNotFoundView();
    }

    return WordMetadataView(metadata: cubit.state.metadata);
  }
}
