import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/core/artificial_intelligence/bridge/ai_bridge_template.dart';
import 'package:open_words/core/result/result.dart';
import 'package:open_words/features/settings/_main_screen/bloc/settings_bloc.dart';
import 'package:open_words/features/settings/ai/ai_bridge_config/bloc/ai_bridge_config_bloc.dart';
import 'package:open_words/features/settings/ai/ai_bridge_tamplate_create/ai_bridge_template_create_page.dart';
import 'package:open_words/shared/navigation/material_navigator.dart';

class AiBridgeFab extends StatelessWidget {
  const AiBridgeFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => _onCreateTamplate(context),
      label: Text("Create"),
      icon: Icon(Icons.account_tree_outlined),
    );
  }

  Future _onCreateTamplate(BuildContext context) async {
    final result = await context.push<AiTemplate>(
      (context) => AiTemplateCreatePage(),
    );

    result.onCreated((value) {
      context.read<AiBridgeConfigBloc>().add(
        AiBridgeConfigTemplateCreated(value),
      );
      context.read<SettingsBloc>().add(
        SettingsAiBridgeChanged(value),
      );
    });
  }
}
