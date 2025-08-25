import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/artificial_intelligence/bridge/ai_bridge_template.dart';
import 'package:open_words/features/settings/ai/ai_bridge_tamplate_create/cubit/ai_bridge_template_create_cubit.dart';
import 'package:open_words/features/settings/ai/ai_bridge_tamplate_create/models/ai_bridge_template_create_step.dart';
import 'package:open_words/features/settings/ai/ai_bridge_tamplate_create/widgets/ai_template_connection_step.dart';
import 'package:open_words/features/settings/ai/ai_bridge_tamplate_create/widgets/ai_template_create_view_fab.dart';
import 'package:open_words/features/settings/ai/ai_bridge_tamplate_create/widgets/ai_template_model_step.dart';
import 'package:open_words/features/settings/ai/ai_bridge_tamplate_create/widgets/ai_template_url_step.dart';
import 'package:open_words/shared/input_fields/text_edit_controller.dart';
import 'package:open_words/shared/layout/constrained_align.dart';
import 'package:open_words/shared/navigation/material_navigator.dart';

class AiTemplateCreatePage extends StatelessWidget {
  final AiTemplate template;

  const AiTemplateCreatePage({
    super.key,
    this.template = const AiTemplate.empty(),
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AiBridgeTemplateCreateCubit(template)..init(),
      child: AiTemplateCreateView(
        initialTemplate: template,
      ),
    );
  }
}

class AiTemplateCreateView extends StatefulWidget {
  final AiTemplate initialTemplate;

  const AiTemplateCreateView({super.key, required this.initialTemplate});

  @override
  State<AiTemplateCreateView> createState() => _AiTemplateCreateViewState();
}

class _AiTemplateCreateViewState extends State<AiTemplateCreateView> {
  final TextEditController model = TextEditController.text();
  final TextEditController url = TextEditController.text();
  final TextEditController api = TextEditController.text();

  late final Map<AiBridgeTemplateCreateStep, Widget> pages;

  @override
  void initState() {
    super.initState();

    model.setText(widget.initialTemplate.model);
    url.setText(widget.initialTemplate.uri);
    api.setText(widget.initialTemplate.apiKey);

    pages = {
      AiBridgeTemplateCreateStep.connectionType: AiTemplateConnectionStep(),
      AiBridgeTemplateCreateStep.url: AiTemplateUrlStep(url: url, api: api),
      AiBridgeTemplateCreateStep.model: AiTemplateModelStep(controller: model),
    };
  }

  @override
  void dispose() {
    super.dispose();

    model.dispose();
    url.dispose();
    api.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final step = context.select(
      (AiBridgeTemplateCreateCubit cubit) => cubit.state.step,
    );
    final isValidStep = context.select(
      (AiBridgeTemplateCreateCubit cubit) => cubit.state.isValidStep,
    );

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) => _onPopInvoked(didPop, step),
      child: Scaffold(
        appBar: AppBar(title: Text(step.label)),
        floatingActionButton: isValidStep ? AiTemplateCreateViewFab() : null,
        body: ConstrainedAlign(child: pages[step]!),
      ),
    );
  }

  void _onPopInvoked(bool didPop, AiBridgeTemplateCreateStep step) {
    if (didPop) {
      return;
    }

    final values = AiBridgeTemplateCreateStep.values;

    final index = values.indexOf(step);

    if (index == 0) {
      context.pop();
      return;
    }

    context.read<AiBridgeTemplateCreateCubit>().previousStep();
  }
}
