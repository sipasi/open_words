import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/core/artificial_intelligence/bridge/ai_bridge_template.dart';
import 'package:open_words/core/services/vibration/vibration_service.dart';
import 'package:open_words/features/settings/_main_screen/bloc/settings_bloc.dart';
import 'package:open_words/features/settings/ai/ai_bridge_config/bloc/ai_bridge_config_bloc.dart';

class AiBridgeClearAllAction extends StatelessWidget {
  final vibration = GetIt.I.get<VibrationService>();

  AiBridgeClearAllAction({super.key});

  @override
  Widget build(BuildContext context) {
    final templates = context.select(
      (AiBridgeConfigBloc bloc) => bloc.state.templates,
    );

    if (templates.isEmpty) {
      return SizedBox.shrink();
    }

    return FilledButton.tonalIcon(
      onPressed: () => _onClearAll(context, templates),
      icon: Icon(Icons.delete_outline),
      label: Text('Clear all'),
    );
  }

  Future _onClearAll(BuildContext context, List<AiTemplate> templates) async {
    final bloc = context.read<AiBridgeConfigBloc>();
    final settings = context.read<SettingsBloc>();

    if (templates.isEmpty) {
      return;
    }

    vibration.mediumImpact(VibrationDuration.medium);

    bloc.add(AiBridgeConfigClearAllRequested());

    settings.add(
      SettingsAiBridgeChanged(const AiTemplate.empty()),
    );
  }
}
