import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/data/entities/metadata/word_metadata.dart';
import 'package:open_words/core/data/entities/word/word.dart';
import 'package:open_words/core/data/entities/word/word_group.dart';
import 'package:open_words/core/services/word_metadata/word_metadata_service.dart';

part 'word_detail_page_state.dart';

class WordDetailPageCubit extends Cubit<WordDetailPageState> {
  final WordGroup group;
  final WordMetadataService metadataService;

  WordDetailPageCubit({
    required this.metadataService,
    required this.group,
    required Word word,
  }) : super(WordDetailPageState.initial(group: group, word: word));

  Future init() async {
    emit(state.copyWith(metadataLoadStatus: MetadataLoadStatus.loading));

    WordMetadata? loaded = await metadataService.localOrWeb(state.origin);

    emit(
      state.copyWith(
        metadataLoadStatus:
            loaded == null
                ? MetadataLoadStatus.failure
                : MetadataLoadStatus.success,
        metadata: loaded,
      ),
    );
  }
}
