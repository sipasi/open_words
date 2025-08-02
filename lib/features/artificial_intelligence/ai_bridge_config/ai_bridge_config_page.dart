import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/core/artificial_intelligence/bridge/ai_bridge_template.dart';
import 'package:open_words/core/result/result.dart';
import 'package:open_words/core/services/ai_bridge/ai_bridge_provider.dart';
import 'package:open_words/core/services/ai_bridge/ai_bridge_tamplate_storage.dart';
import 'package:open_words/core/services/vibration/vibration_service.dart';
import 'package:open_words/features/artificial_intelligence/ai_bridge_tamplate_create/ai_bridge_template_create_sheet.dart';
import 'package:open_words/features/settings/bloc/settings_bloc.dart';
import 'package:open_words/shared/card/radio_card.dart';

class AiBridgeConfigPage extends StatefulWidget {
  const AiBridgeConfigPage({super.key});

  @override
  State<AiBridgeConfigPage> createState() => _AiBridgeConfigPageState();
}

class _AiBridgeConfigPageState extends State<AiBridgeConfigPage> {
  final vibration = GetIt.I.get<VibrationService>();

  final aiBridgeProvider = GetIt.I.get<AiBridgeProvider>();
  final aiBridgeTemplateStorage = GetIt.I.get<AiBridgeTamplateStorage>();

  String connectionStatus = "";

  AiBridgeTemplate? selected;
  List<AiBridgeTemplate> templates = const [];

  @override
  void initState() {
    super.initState();

    selected = AiBridgeTemplate.from(aiBridgeProvider.get());
    templates = aiBridgeTemplateStorage.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tamplates"),
        actions: [
          FilledButton.tonalIcon(
            onPressed: _onClearAll,
            icon: Icon(Icons.delete_outline),
            label: Text('Clear all'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _onCreateTamplate(context),
        label: Text("Create"),
        icon: Icon(Icons.account_tree_outlined),
      ),
      body: ListView.builder(
        itemCount: templates.length,
        itemBuilder: (context, index) {
          final item = templates[index];

          return RadioCard(
            title: Text(item.model),
            subtitle: Text('${item.type.name} ${item.uri}'),
            data: item,
            id: item.id,
            groupId: selected?.id,
            onTap: _onTap,
            onLongPress: (data) => _onLongPress(context, data),
          );
        },
      ),
    );
  }

  Future _onClearAll() async {
    if (templates.isEmpty) {
      return;
    }

    vibration.mediumImpact(VibrationDuration.medium);

    await aiBridgeTemplateStorage.clear();

    sendToSettingsBloc(const AiBridgeTemplate.empty());

    setState(() => templates = const []);
  }

  void _onTap(AiBridgeTemplate value) {
    final next = selected?.id == value.id
        ? const AiBridgeTemplate.empty()
        : value;

    vibration.mediumImpact(VibrationDuration.medium);

    setState(() => selected = next);

    sendToSettingsBloc(next);
  }

  Future _onLongPress(BuildContext context, AiBridgeTemplate value) async {
    final result = await AiBridgeTemplateCreateSheet.showSheet(
      context: context,
      tamplate: value,
    );

    result.onModified((value) async {
      await aiBridgeTemplateStorage.replace(id: value.id, value: value);

      if (!context.mounted) {
        return;
      }

      _changeSettingsIfSelectedIdEquals(
        value,
      );

      _reloadTemplates();
    });

    result.onDeleted((value) async {
      await aiBridgeTemplateStorage.remove(value.id);

      if (!context.mounted) {
        return;
      }

      _changeSettingsIfSelectedIdEquals(
        const AiBridgeTemplate.empty(),
      );

      _reloadTemplates();
    });
  }

  Future _onCreateTamplate(BuildContext context) async {
    final result = await AiBridgeTemplateCreateSheet.showSheet(
      context: context,
    );

    result.onCreated((value) {
      aiBridgeTemplateStorage.add(value);

      _reloadTemplates();
    });
  }

  void _changeSettingsIfSelectedIdEquals(AiBridgeTemplate template) {
    if (template.id == selected?.id) {
      sendToSettingsBloc(template);
    }
  }

  void sendToSettingsBloc(AiBridgeTemplate template) {
    context.read<SettingsBloc>().add(
      SettingsAiBridgeChanged(template),
    );
  }

  void _reloadTemplates() {
    setState(() => templates = aiBridgeTemplateStorage.getAll());
  }
}
