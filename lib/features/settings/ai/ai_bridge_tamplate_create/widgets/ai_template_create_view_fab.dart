import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/result/result.dart';
import 'package:open_words/features/settings/ai/ai_bridge_tamplate_create/cubit/ai_bridge_template_create_cubit.dart';
import 'package:open_words/shared/navigation/material_navigator.dart';

class AiTemplateCreateViewFab extends StatelessWidget {
  const AiTemplateCreateViewFab({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AiBridgeTemplateCreateCubit>();

    if (bloc.state.isLastStep) {
      return FloatingActionButton.extended(
        onPressed: () => _onSave(context),
        icon: Icon(Icons.done),
        label: Text('Finish'),
      );
    }

    return FloatingActionButton.extended(
      onPressed: () => _onNextStep(context),
      icon: Icon(Icons.navigate_next),
      label: Text('Next'),
    );
  }

  void _onNextStep(BuildContext context) {
    final bloc = context.read<AiBridgeTemplateCreateCubit>();

    bloc.nextStep();
  }

  void _onSave(BuildContext context) {
    final bloc = context.read<AiBridgeTemplateCreateCubit>();

    final isEdit = bloc.initial.id != '';

    final resultType = isEdit ? CrudResult.modified : CrudResult.created;

    final tamplate = bloc.createTemplate();

    context.popWith(resultType(tamplate));
  }
}
