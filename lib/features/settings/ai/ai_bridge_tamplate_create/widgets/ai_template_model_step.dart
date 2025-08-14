import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/settings/ai/ai_bridge_tamplate_create/cubit/ai_bridge_template_create_cubit.dart';
import 'package:open_words/features/settings/ai/ai_bridge_tamplate_create/widgets/ai_bridge_template_create_page.dart';
import 'package:open_words/shared/input_fields/text_edit_controller.dart';

class AiTemplateModelStep extends StatelessWidget {
  final TextEditController controller;

  const AiTemplateModelStep({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AiBridgeTemplateCreateCubit>();
    final models = context.select(
      (AiBridgeTemplateCreateCubit value) => value.state.models,
    );
    final model = context.select(
      (AiBridgeTemplateCreateCubit value) => value.state.model,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFieldWithPaste(
          controller: controller,
          label: 'Model',
          onChanged: cubit.setModel,
          onPaste: cubit.setModel,
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.start,
            children: List.generate(
              models.length,
              (index) {
                final value = models[index];

                return ChoiceChip(
                  label: Text(value.name),
                  selected: value.name == model,
                  showCheckmark: false,
                  onSelected: (_) {
                    cubit.setModel(value.name);
                    controller.setText(value.name);
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
