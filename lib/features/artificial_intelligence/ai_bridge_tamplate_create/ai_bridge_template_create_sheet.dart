import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/core/artificial_intelligence/bridge/ai_bridge_template.dart';
import 'package:open_words/core/artificial_intelligence/bridge/ai_bridge_type.dart';
import 'package:open_words/core/result/result.dart';
import 'package:open_words/core/services/clipboard/clipboard.dart';
import 'package:open_words/core/services/vibration/vibration_service.dart';
import 'package:open_words/shared/bottom_sheet/dismissible_bottom_sheet.dart';
import 'package:open_words/shared/bottom_sheet/editor/editor_bottom_bar.dart';
import 'package:open_words/shared/card/radio_card.dart';
import 'package:open_words/shared/input_fields/text_edit_controller.dart';
import 'package:open_words/shared/input_fields/text_edit_field.dart';
import 'package:open_words/shared/navigation/material_navigator.dart';
import 'package:open_words/shared/theme/theme_extension.dart';
import 'package:uuid/v4.dart';

class AiBridgeTemplateCreateSheet extends StatefulWidget {
  final AiBridgeTemplate? tamplate;

  const AiBridgeTemplateCreateSheet({super.key, this.tamplate});

  static Future<Result<AiBridgeTemplate>> showSheet({
    required BuildContext context,
    AiBridgeTemplate? tamplate,
  }) {
    return context.pushSmoothSheet<AiBridgeTemplate>(
      (context) => AiBridgeTemplateCreateSheet(
        tamplate: tamplate,
      ),
    );
  }

  @override
  State<AiBridgeTemplateCreateSheet> createState() =>
      _AiBridgeTemplateCreateSheetState();
}

class _AiBridgeTemplateCreateSheetState
    extends State<AiBridgeTemplateCreateSheet> {
  final vibration = GetIt.I.get<VibrationService>();
  final clipboard = GetIt.I.get<ClipboardService>();

  final TextEditController model = TextEditController.text();
  final TextEditController url = TextEditController.text();
  final TextEditController api = TextEditController.text();

  AiBridgeType selected = AiBridgeType.lan;

  bool get isValid =>
      model.textTrim.isNotEmpty && Uri.tryParse(url.textTrim) != null;

  bool get isEdit => widget.tamplate != null;

  @override
  void initState() {
    super.initState();

    final tamplate = widget.tamplate;

    if (tamplate == null) {
      return;
    }

    model.setText(tamplate.model);
    url.setText(tamplate.uri.toString());
    api.setText(tamplate.apiKey.toString());
    selected = tamplate.type;
  }

  @override
  void dispose() {
    super.dispose();

    model.dispose();
    url.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DismissibleBottomSheet(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 20,
            children: [
              _textWithPaste(
                controller: model,
                label: "Model",
              ),
              _textWithPaste(
                controller: url,
                label: "Url",
              ),
              if (selected.isRemote)
                _textWithPaste(
                  controller: api,
                  label: "Api Key",
                ),
              Column(
                children: [
                  Text(
                    "Conntection type",
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _radioCard(
                    type: AiBridgeType.lan,
                    subtitle: "Connects to a device on the same local network",
                  ),
                  _radioCard(
                    type: AiBridgeType.local,
                    subtitle: "Connects to your own device. No network used",
                  ),
                  _radioCard(
                    type: AiBridgeType.remote,
                    subtitle:
                        "Connects to a server or AI service over the internet",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomBar: EditorBottomBar(
        onSubmitPressed: isValid ? () => _onSave(context) : null,
        actions: [
          if (isEdit)
            FilledButton.icon(
              onPressed: () => _onDelete(context),
              label: Text("Delete"),
              icon: Icon(Icons.delete_outline),
            ),
        ],
      ),
    );
  }

  Future _onDelete(BuildContext context) async {
    if (!context.mounted || widget.tamplate == null) {
      return;
    }

    context.popWith(CrudResult.deleted(widget.tamplate!));
  }

  void _onSave(BuildContext context) {
    final resultType = isEdit ? CrudResult.modified : CrudResult.created;

    final tamplate = AiBridgeTemplate(
      id: isEdit ? widget.tamplate!.id : UuidV4().generate(),
      uri: url.textTrim,
      model: model.textTrim,
      type: selected,
      apiKey: selected.isRemote ? api.textTrim : '',
    );

    context.popWith(resultType(tamplate));
  }

  Widget _textWithPaste({
    required TextEditController controller,
    required String label,
  }) {
    return Row(
      children: [
        Expanded(
          child: TextEditField(
            controller: controller,
            label: label,
            border: OutlineInputBorder(),
            onChanged: (value) => setState(() {}),
          ),
        ),
        IconButton(
          icon: Icon(Icons.paste),
          onPressed: () async {
            final text = await clipboard.getText();

            if (text.isNotEmpty) {
              vibration.mediumImpact(VibrationDuration.medium);

              setState(() {
                controller.setText(text);
              });
            }
          },
        ),
      ],
    );
  }

  Widget _radioCard({
    required AiBridgeType type,
    required String subtitle,
  }) {
    return RadioCard.outlined(
      data: type,
      id: type,
      groupId: selected,
      title: Text(type.name),
      subtitle: Text(subtitle),
      onTap: (value) {
        vibration.mediumImpact(VibrationDuration.medium);

        setState(() {
          selected = value;
        });
      },
    );
  }
}
