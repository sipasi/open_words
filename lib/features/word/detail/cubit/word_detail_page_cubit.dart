import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/data/entities/game/word_statistic.dart';
import 'package:open_words/core/data/entities/id.dart';
import 'package:open_words/core/data/entities/metadata/word_metadata.dart';
import 'package:open_words/core/data/entities/word/word.dart';
import 'package:open_words/core/data/entities/word/word_group.dart';
import 'package:open_words/core/data/repository/word_statistic_repository.dart';
import 'package:open_words/core/services/word_metadata/word_metadata_service.dart';
import 'package:open_words/features/word/detail/models/metadata_load_status.dart';
import 'package:open_words/features/word/detail/models/statistic_load_status.dart';

part 'word_detail_page_state.dart';

class WordDetailPageCubit extends Cubit<WordDetailPageState> {
  final Id wordId;
  final WordGroup group;
  final WordMetadataService metadataService;
  final WordStatisticRepository statisticRepository;

  WordDetailPageCubit({
    required this.metadataService,
    required this.statisticRepository,
    required this.group,
    required Word word,
  }) : wordId = word.id,
       super(WordDetailPageState.initial(group: group, word: word));

  Future init() {
    return loading();
  }

  Future refresh() {
    return loading();
  }

  Future loading() async {
    return Future.wait([_statisticLoading(), _metadataLoading()]);
  }

  Future _statisticLoading() async {
    emit(state.copyWith(statisticLoadStatus: StatisticLoadStatus.loading));

    final statistic = await statisticRepository.getByWord(state.origin);

    emit(
      state.copyWith(
        statistic: statistic,
        statisticLoadStatus: StatisticLoadStatus.success,
      ),
    );
  }

  Future _metadataLoading() async {
    emit(state.copyWith(metadataLoadStatus: MetadataLoadStatus.loading));

    // Currently supports only English language ):
    WordMetadata? loaded = switch (group.origin.code) {
      'en' => await metadataService.localOrWeb(state.origin),
      _ => await metadataService.localOnly(state.origin),
    };

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
