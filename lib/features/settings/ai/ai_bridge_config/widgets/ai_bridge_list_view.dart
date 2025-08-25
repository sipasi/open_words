import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/core/artificial_intelligence/bridge/ai_bridge_template.dart';
import 'package:open_words/core/result/result.dart';
import 'package:open_words/core/services/vibration/vibration_service.dart';
import 'package:open_words/features/settings/_main_screen/bloc/settings_bloc.dart';
import 'package:open_words/features/settings/ai/ai_bridge_config/bloc/ai_bridge_config_bloc.dart';
import 'package:open_words/features/settings/ai/ai_bridge_tamplate_create/ai_bridge_template_create_page.dart';
import 'package:open_words/shared/card/radio_card.dart';
import 'package:open_words/shared/layout/constrained_align.dart';
import 'package:open_words/shared/navigation/material_navigator.dart';

class AiBridgeListView extends StatelessWidget {
  final vibration = GetIt.I.get<VibrationService>();

  AiBridgeListView({super.key});

  @override
  Widget build(BuildContext context) {
    final selected = context.select(
      (AiBridgeConfigBloc value) => value.state.selected,
    );
    final templates = context.select(
      (AiBridgeConfigBloc value) => value.state.templates,
    );

    return ConstrainedAlign(
      child: ListView.builder(
        itemCount: templates.length,
        itemBuilder: (context, index) {
          final item = templates[index];

          return RadioCard(
            title: Text(item.model),
            subtitle: Text('${item.type.name} ${item.uri}'),
            data: item,
            id: item.id,
            groupId: selected.id,
            onTap: (value) => _onTap(context, selected, value),
            onLongPress: (value) => _onLongPress(context, value),
          );
        },
      ),
    );
  }

  void _onTap(BuildContext context, AiTemplate selected, AiTemplate value) {
    final next = selected.id == value.id ? const AiTemplate.empty() : value;

    vibration.mediumImpact(VibrationDuration.medium);

    context.read<AiBridgeConfigBloc>().add(
      AiBridgeConfigSelectedChanged(next),
    );
    context.read<SettingsBloc>().add(
      SettingsAiBridgeChanged(next),
    );
  }

  Future _onLongPress(BuildContext context, AiTemplate value) async {
    final result = await context.push<AiTemplate>(
      (context) => AiTemplateCreatePage(
        template: value,
      ),
    );

    result.onModified((modified) {
      context.read<AiBridgeConfigBloc>().add(
        AiBridgeConfigTemplateModified(initial: value, newValue: modified),
      );
      context.read<SettingsBloc>().add(
        SettingsAiBridgeChanged(modified),
      );
    });

    result.onDeleted((deleted) async {
      context.read<AiBridgeConfigBloc>().add(
        AiBridgeConfigTemplateDeleted(deleted),
      );
      context.read<SettingsBloc>().add(
        SettingsAiBridgeChanged(const AiTemplate.empty()),
      );
    });
  }
}
