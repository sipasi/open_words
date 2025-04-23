part of 'word_detail_page_cubit.dart';

enum MetadataLoadStatus { loading, success, failure }

extension MetadataLoadStatusExtension on MetadataLoadStatus {
  bool get isLoading => this == MetadataLoadStatus.loading;
  bool get isSuccess => this == MetadataLoadStatus.success;
  bool get isFailure => this == MetadataLoadStatus.failure;
}

class WordDetailPageState {
  final WordGroup group;

  final String origin;
  final String translation;

  final MetadataLoadStatus metadataLoadStatus;

  final WordMetadata metadata;

  WordDetailPageState({
    required this.group,
    required this.origin,
    required this.translation,
    required this.metadataLoadStatus,
    required this.metadata,
  });
  WordDetailPageState.initial({required this.group, required Word word})
    : origin = word.origin,
      translation = word.translation,
      metadata = const WordMetadata.empty(),
      metadataLoadStatus = MetadataLoadStatus.loading;

  WordDetailPageState copyWith({
    String? origin,
    String? translation,
    MetadataLoadStatus? metadataLoadStatus,
    WordMetadata? metadata,
  }) {
    return WordDetailPageState(
      group: group,
      origin: origin ?? this.origin,
      translation: translation ?? this.translation,
      metadataLoadStatus: metadataLoadStatus ?? this.metadataLoadStatus,
      metadata: metadata ?? this.metadata,
    );
  }
}
