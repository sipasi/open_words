part of 'word_metadata_update_cubit.dart';

class DownloadInfo {
  final String name;

  final DownloadInfoStatus downloadStatus;

  DownloadInfo({required this.name, required this.downloadStatus});
  DownloadInfo.fromWord(
    Word word, [
    this.downloadStatus = DownloadInfoStatus.none,
  ]) : name = word.origin;

  DownloadInfo copyWith({String? name, DownloadInfoStatus? downloadStatus}) {
    return DownloadInfo(
      name: name ?? this.name,
      downloadStatus: downloadStatus ?? this.downloadStatus,
    );
  }
}

enum DownloadInfoStatus {
  none('none'),
  exist('exist'),
  notFound('Not found in web'),
  downloaded('Now downloaded');

  bool get isNotExist => this != DownloadInfoStatus.exist;
  bool get isNotFound => this == DownloadInfoStatus.notFound;
  bool get isDownloaded => this == DownloadInfoStatus.downloaded;

  final String title;
  const DownloadInfoStatus(this.title);
}

enum UpdateStatus {
  prepearing,
  noInternet,
  updating,
  finished;

  bool get isPrepearing => this == UpdateStatus.prepearing;
  bool get isNoInternet => this == UpdateStatus.noInternet;
  bool get isUpdating => this == UpdateStatus.updating;
  bool get isFinished => this == UpdateStatus.finished;

  bool get inProgress => isPrepearing || isUpdating;
}

class WordMetadataUpdateState {
  final List<DownloadInfo> needDownload;
  final List<DownloadInfo> alreadyDownloaded;
  final UpdateStatus updateStatus;

  double get progress => getPercentage(
    alreadyDownloaded.length.toDouble(),
    needDownload.length.toDouble(),
  );

  String get progressText => progress.toStringAsFixed(0);

  WordMetadataUpdateState({
    required this.needDownload,
    required this.alreadyDownloaded,
    required this.updateStatus,
  });
  WordMetadataUpdateState.initial()
    : needDownload = const [],
      alreadyDownloaded = const [],
      updateStatus = UpdateStatus.prepearing;

  WordMetadataUpdateState copyWith({
    List<DownloadInfo>? needDownload,
    List<DownloadInfo>? alreadyDownloaded,
    UpdateStatus? updateStatus,
  }) {
    return WordMetadataUpdateState(
      needDownload: needDownload ?? this.needDownload,
      alreadyDownloaded: alreadyDownloaded ?? this.alreadyDownloaded,
      updateStatus: updateStatus ?? this.updateStatus,
    );
  }

  static double getPercentage(double part, double total) {
    if (total == 0) return 0;

    return (part / total) * 100;
  }
}
