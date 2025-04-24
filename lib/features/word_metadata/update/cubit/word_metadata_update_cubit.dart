import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/data/entities/word/word.dart';
import 'package:open_words/core/data/repository/word_metadata_repository.dart';
import 'package:open_words/core/services/vibration/vibration_service.dart';
import 'package:open_words/core/services/word_metadata/word_metadata_web_api.dart';

part 'word_metadata_update_state.dart';

class WordMetadataUpdateCubit extends Cubit<WordMetadataUpdateState> {
  final List<Word> words;
  final WordMetadataRepository metadataRepository;
  final WordMetadataWebApi metadataWebApi;
  final VibrationService vibrationService;

  WordMetadataUpdateCubit({
    required this.words,
    required this.metadataRepository,
    required this.metadataWebApi,
    required this.vibrationService,
  }) : super(WordMetadataUpdateState.initial());

  Future init() async {
    if (await _noInternet()) {
      emit(state.copyWith(updateStatus: UpdateStatus.noInternet));

      return;
    }

    await _simulateInitialDelay();

    final downloads = await _generateDownloadInfo();

    emit(
      state.copyWith(
        needDownload:
            downloads
                .where((element) => element.downloadStatus.isNotExist)
                .toList(),
      ),
    );

    await _startUpdating();
  }

  Future _startUpdating() async {
    for (var download in state.needDownload) {
      final updated = await _tryDownloadAndStore(download);

      emit(
        state.copyWith(
          alreadyDownloaded: [...state.alreadyDownloaded, updated],
        ),
      );

      vibrationService.lightImpact(VibrationDuration.short);
    }

    emit(state.copyWith(updateStatus: UpdateStatus.finished));
  }

  Future<DownloadInfo> _tryDownloadAndStore(DownloadInfo download) async {
    final apiResult = await metadataWebApi.find(download.name);

    if (apiResult != null) {
      await metadataRepository.create(apiResult);
    }

    await _delayBasedOnResult(apiResult);

    return download.copyWith(
      downloadStatus:
          apiResult == null
              ? DownloadInfoStatus.notFound
              : DownloadInfoStatus.downloaded,
    );
  }

  Future<List<DownloadInfo>> _generateDownloadInfo() async {
    return await Future.wait(
      words.map(
        (word) async => switch (await metadataRepository.exist(word.origin)) {
          true => DownloadInfo.fromWord(word, DownloadInfoStatus.exist),
          _ => DownloadInfo.fromWord(word),
        },
      ),
    );
  }

  static Future<bool> _noInternet() async {
    final connectivity = await (Connectivity().checkConnectivity());

    return connectivity.contains(ConnectivityResult.none);
  }

  Future<void> _simulateInitialDelay() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> _delayBasedOnResult(result) async {
    await Future.delayed(Duration(milliseconds: result == null ? 800 : 400));
  }
}
