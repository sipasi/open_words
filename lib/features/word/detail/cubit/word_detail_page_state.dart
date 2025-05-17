part of 'word_detail_page_cubit.dart';

class WordDetailPageState {
  final WordGroup group;

  final String origin;
  final String translation;

  final WordStatistic statistic;
  final StatisticLoadStatus statisticLoadStatus;

  final WordMetadata metadata;
  final MetadataLoadStatus metadataLoadStatus;

  WordDetailPageState({
    required this.group,
    required this.origin,
    required this.translation,
    required this.metadata,
    required this.metadataLoadStatus,
    required this.statistic,
    required this.statisticLoadStatus,
  });
  WordDetailPageState.initial({required this.group, required Word word})
    : origin = word.origin,
      translation = word.translation,
      metadata = const WordMetadata.empty(),
      metadataLoadStatus = MetadataLoadStatus.loading,
      statistic = const WordStatistic.empty(),
      statisticLoadStatus = StatisticLoadStatus.loading;

  WordDetailPageState copyWith({
    String? origin,
    String? translation,
    MetadataLoadStatus? metadataLoadStatus,
    WordMetadata? metadata,
    WordStatistic? statistic,
    StatisticLoadStatus? statisticLoadStatus,
  }) {
    return WordDetailPageState(
      group: group,
      origin: origin ?? this.origin,
      translation: translation ?? this.translation,
      metadataLoadStatus: metadataLoadStatus ?? this.metadataLoadStatus,
      metadata: metadata ?? this.metadata,
      statistic: statistic ?? this.statistic,
      statisticLoadStatus: statisticLoadStatus ?? this.statisticLoadStatus,
    );
  }
}
