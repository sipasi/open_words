import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/features/settings/add_preinstalled/model/language_info_resolver.dart';
import 'package:open_words/features/settings/add_preinstalled/model/preinstalled_pack.dart';
import 'package:open_words/features/settings/add_preinstalled/usecase/get_assets_path_list_usecase.dart';

sealed class LoadPreinstalledPackUsecase {
  static Future<List<PreinstalledPack>> invoke() async {
    List<PreinstalledPack> packs = [];

    final assets = GetAssetsPathListUsecase.invoke();

    for (var element in assets) {
      final json = await rootBundle.loadString(element);

      final pack = PreinstalledPack.fromJson(
        languageResolver: LanguageInfoResolver(service: GetIt.I.get()),
        source: json,
      );

      packs.add(pack);
    }

    return packs;
  }
}
