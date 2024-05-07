import 'download_status.dart';

class DownloadInfo {
  final String name;

  DownloadStatus state = DownloadStatus.notStarted;

  String? message;

  DownloadInfo({required this.name});

  bool isNotStarted() => state == DownloadStatus.notStarted;
  bool isDownloading() => state == DownloadStatus.downloading;
  bool isDownloaded() => state == DownloadStatus.downloaded;
  bool isError() => state == DownloadStatus.error;

  void downloading() => state = DownloadStatus.downloading;
  void downloaded() => state = DownloadStatus.downloaded;
  void error(String message) => this
    ..state = DownloadStatus.error
    ..message = message;
}
