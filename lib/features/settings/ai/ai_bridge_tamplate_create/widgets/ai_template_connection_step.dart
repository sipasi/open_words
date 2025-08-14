import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:open_words/core/artificial_intelligence/bridge/ai_bridge_type.dart';
import 'package:open_words/core/services/vibration/vibration_service.dart';
import 'package:open_words/features/settings/ai/ai_bridge_tamplate_create/cubit/ai_bridge_template_create_cubit.dart';
import 'package:open_words/shared/card/radio_card.dart';

class AiTemplateConnectionStep extends StatelessWidget {
  const AiTemplateConnectionStep({super.key});

  @override
  Widget build(BuildContext context) {
    final bridgeType = context.select(
      (AiBridgeTemplateCreateCubit cubit) => cubit.state.bridgeType,
    );

    return Column(
      children: [
        _radioCard(
          context: context,
          type: AiBridgeType.lan,
          current: bridgeType,
          subtitle: "Connects to a device on the same local network",
        ),
        _radioCard(
          context: context,
          type: AiBridgeType.local,
          current: bridgeType,
          subtitle: "Connects to your own device. No network used",
        ),
        _radioCard(
          context: context,
          type: AiBridgeType.remote,
          current: bridgeType,
          subtitle: "Connects to a server or AI service over the internet",
        ),
      ],
    );
  }

  Widget _radioCard({
    required BuildContext context,
    required AiBridgeType type,
    required AiBridgeType current,
    required String subtitle,
  }) {
    final cubit = context.read<AiBridgeTemplateCreateCubit>();

    return RadioCard.outlined(
      data: type,
      id: type,
      groupId: current,
      title: Text(type.name),
      subtitle: Text(subtitle),
      onTap: (value) {
        GetIt.I.get<VibrationService>().mediumImpact(VibrationDuration.medium);

        cubit.setConnectionType(value);
      },
    );
  }
}
