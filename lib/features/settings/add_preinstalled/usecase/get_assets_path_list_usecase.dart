import 'package:open_words/core/generated/assets/assets.gen.dart';

sealed class GetAssetsPathListUsecase {
  static List<String> invoke() {
    return Assets.json.dictionary.ukrainian.values;
  }
}
