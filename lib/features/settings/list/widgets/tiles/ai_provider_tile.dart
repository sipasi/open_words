import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/artificial_intelligence/bridge/ai_bridge_type.dart';
import 'package:open_words/features/settings/ai/ai_bridge_config/ai_bridge_config_page.dart';
import 'package:open_words/features/settings/list/bloc/settings_bloc.dart';
import 'package:open_words/shared/navigation/material_navigator.dart';

class AiProviderTile extends StatelessWidget {
  const AiProviderTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        final aiBridge = state.aiBridgeTemplate;

        final subtitle = switch (aiBridge.type) {
          AiBridgeType.notConfigured => "No configuation selected",
          _ => "${aiBridge.model} ${aiBridge.type.name}",
        };

        return ListTile(
          title: Text('Ai Provider'),
          subtitle: Text(subtitle),
          trailing: Icon(Icons.psychology_outlined),
          onTap: () => context.push((context) => AiBridgeConfigPage()),
        );
      },
    );
  }
}
