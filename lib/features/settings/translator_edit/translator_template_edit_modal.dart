import 'package:flutter/material.dart';
import 'package:open_words/core/services/language/translation/translator_template.dart';
import 'package:open_words/core/services/language/translation/translator_template_storage.dart';
import 'package:open_words/features/settings/list/bloc/settings_bloc.dart';
import 'package:open_words/features/settings/translator_edit/usecase/translator_update_storage_and_settings_usecase.dart';
import 'package:open_words/features/settings/translator_edit/widgets/translator_template_view.dart';

class TranslatorTemplateEditModal {
  static Future dialog({
    required BuildContext context,
    required TranslatorTemplateStorage storage,
    required SettingsBloc bloc,
    required TranslatorTemplate current,
  }) async {
    TranslatorTemplate temp = current;

    await showDialog(
      context: context,
      builder: (context) => Dialog(
        child: StatefulBuilder(
          builder: (context, setState) => TranslatorTemplateView(
            template: temp,
            onChanged: (template) {
              setState(() => temp = template);

              TranslatorUpdateStorageAndSettingsUsecase.invoke(
                storage: storage,
                bloc: bloc,
                template: template,
              );
            },
          ),
        ),
      ),
    );
  }
}
