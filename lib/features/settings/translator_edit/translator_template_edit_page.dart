import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/core/services/language/translation/translator_template.dart';
import 'package:open_words/core/services/language/translation/translator_template_storage.dart';
import 'package:open_words/features/settings/_main_screen/bloc/settings_bloc.dart';
import 'package:open_words/features/settings/translator_edit/usecase/translator_update_storage_and_settings_usecase.dart';
import 'package:open_words/features/settings/translator_edit/widgets/translator_template_view.dart';
import 'package:open_words/shared/layout/constrained_align.dart';

class TranslatorTemplateEditPage extends StatefulWidget {
  const TranslatorTemplateEditPage({super.key});

  @override
  State<TranslatorTemplateEditPage> createState() =>
      _TranslatorTemplateEditPageState();
}

class _TranslatorTemplateEditPageState
    extends State<TranslatorTemplateEditPage> {
  late TranslatorTemplateStorage templateStorage;
  late TranslatorTemplate template;

  @override
  void initState() {
    super.initState();

    templateStorage = GetIt.I.get();
    template = templateStorage.getOrDefault();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Templates')),
      body: ConstrainedAlign(
        alignment: AlignmentGeometry.topCenter,
        child: TranslatorTemplateView(
          template: template,
          onChanged: (template) {
            setState(() => this.template = template);

            TranslatorUpdateStorageAndSettingsUsecase.invoke(
              storage: templateStorage,
              bloc: context.read<SettingsBloc>(),
              template: template,
            );
          },
        ),
      ),
    );
  }
}
