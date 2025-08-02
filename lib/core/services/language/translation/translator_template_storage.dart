import 'package:open_words/core/services/language/translation/translator_template.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class TranslatorTemplateStorage {
  const TranslatorTemplateStorage();

  Future set(TranslatorTemplate template);

  TranslatorTemplate getOrDefault();
}

final class TranslatorTemplateStorageImpl extends TranslatorTemplateStorage {
  static const _key = 'translator_template_key';

  final SharedPreferences _preferences;

  const TranslatorTemplateStorageImpl(this._preferences);

  @override
  TranslatorTemplate getOrDefault() {
    final json = _preferences.getString(_key);

    return json == null
        ? TranslatorTemplate.google()
        : TranslatorTemplate.fromJson(json);
  }

  @override
  Future set(TranslatorTemplate template) {
    return _preferences.setString(_key, template.toJson());
  }
}
