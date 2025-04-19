import 'package:open_words/core/services/language/translation/translator_option.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class TranslatorOptionStorage {
  const TranslatorOptionStorage();

  void remember(TranslatorOption option);

  TranslatorOption rememberedOrDefault();
}

final class TranslatorOptionStorageImpl extends TranslatorOptionStorage {
  static const _key = 'translator_url_key';

  final SharedPreferences _preferences;

  const TranslatorOptionStorageImpl(this._preferences);

  @override
  TranslatorOption rememberedOrDefault() {
    final selection = _preferences.getInt(_key) ?? 0;

    return outOfRange(selection)
        ? TranslatorOption.google
        : TranslatorOption.values[selection];
  }

  @override
  void remember(TranslatorOption option) {
    outOfRange(option.index)
        ? _preferences.setInt(_key, 0)
        : _preferences.setInt(_key, option.index);
  }

  bool outOfRange(int index) {
    return index < 0 || index >= TranslatorOption.values.length;
  }
}
