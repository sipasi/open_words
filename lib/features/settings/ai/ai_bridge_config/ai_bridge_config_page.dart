import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/features/settings/ai/ai_bridge_config/bloc/ai_bridge_config_bloc.dart';
import 'package:open_words/features/settings/ai/ai_bridge_config/widgets/ai_bridge_clear_all_action.dart';
import 'package:open_words/features/settings/ai/ai_bridge_config/widgets/ai_bridge_fab.dart';
import 'package:open_words/features/settings/ai/ai_bridge_config/widgets/ai_bridge_list_view.dart';

class AiBridgeConfigPage extends StatelessWidget {
  const AiBridgeConfigPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AiBridgeConfigBloc(
        aiBridgeProvider: GetIt.I.get(),
        aiBridgeTemplateStorage: GetIt.I.get(),
      )..add(AiBridgeConfigStarted()),
      child: AiBridgeConfigView(),
    );
  }
}

class AiBridgeConfigView extends StatelessWidget {
  const AiBridgeConfigView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tamplates"),
        actions: [
          AiBridgeClearAllAction(),
        ],
      ),
      floatingActionButton: AiBridgeFab(),
      body: AiBridgeListView(),
    );
  }
}
