import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_words/features/settings/ai/ai_bridge_tamplate_create/cubit/ai_bridge_template_create_cubit.dart';
import 'package:open_words/features/settings/ai/ai_bridge_tamplate_create/widgets/ai_bridge_template_create_page.dart';
import 'package:open_words/features/settings/ai/ai_bridge_tamplate_create/widgets/ip_address_list_view.dart';
import 'package:open_words/shared/input_fields/text_edit_controller.dart';

class AiTemplateUrlStep extends StatelessWidget {
  final TextEditController url;
  final TextEditController api;

  const AiTemplateUrlStep({
    super.key,
    required this.url,
    required this.api,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AiBridgeTemplateCreateCubit>();

    final type = cubit.state.bridgeType;
    final localAddress = cubit.state.localIp;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFieldWithPaste(
          controller: url,
          label: 'Server',
          onChanged: cubit.setUrl,
          onPaste: cubit.setUrl,
        ),
        if (type.isLanOrLocal && localAddress.isNotEmpty)
          IpAddressListView(
            address: localAddress,
            onSelected: (value) => _onAddressSelected(context, value),
          ),
        if (type.isRemote)
          TextFieldWithPaste(
            controller: api,
            label: 'Api',
            onChanged: cubit.setApi,
            onPaste: cubit.setApi,
          ),
      ],
    );
  }

  void _onAddressSelected(BuildContext context, String value) {
    final cubit = context.read<AiBridgeTemplateCreateCubit>();

    url.clear();
    url.setText(value);

    cubit.setUrl(value);
  }
}
