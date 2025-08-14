import 'package:open_words/core/services/language/translation/translator_template.dart';
import 'package:open_words/core/services/language/translation/translator_template_storage.dart';
import 'package:open_words/features/settings/list/bloc/settings_bloc.dart';

sealed class TranslatorUpdateStorageAndSettingsUsecase {
  static Future invoke({
    required TranslatorTemplateStorage storage,
    required SettingsBloc bloc,
    required TranslatorTemplate template,
  }) {
    bloc.add(
      SettingsTranslatorChanged(template),
    );

    return storage.set(template);
  }
}
