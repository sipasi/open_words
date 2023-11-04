import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/data/language_info.dart';
import 'package:open_words/data/metadata/word_metadata.dart';
import 'package:open_words/service/metadata/metadata_service.dart';
import 'package:open_words/view/shared/future_state.dart';
import 'package:open_words/view/word/detail/metadata/word_metadata_view.dart';

class WordMetadataLoaderView extends StatefulWidget {
  final String word;
  final LanguageInfo language;

  const WordMetadataLoaderView({
    super.key,
    required this.word,
    required this.language,
  });

  @override
  State<WordMetadataLoaderView> createState() => _WordMetadataLoaderViewState();
}

class _WordMetadataLoaderViewState extends FutureState<WordMetadataLoaderView, WordMetadata?> {
  @override
  Future<WordMetadata?> getFuture() async {
    final metadataService = GetIt.I.get<MetadataService>();

    return metadataService.localOrWeb(widget.word);
  }

  @override
  Widget successBuild(BuildContext context, WordMetadata? data) {
    if (data == null) {
      final textStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          );

      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Text(
            'Metadata has not found',
            style: textStyle,
          ),
        ),
      );
    }

    return WordMetadataView(metadata: data, language: widget.language);
  }
}
