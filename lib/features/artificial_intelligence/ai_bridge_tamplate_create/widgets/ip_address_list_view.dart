import 'package:flutter/material.dart';
import 'package:open_words/features/artificial_intelligence/ai_bridge_tamplate_create/models/local_ip_addresses.dart';

class IpAddressListView extends StatelessWidget {
  final LocalIpAddresses address;
  final void Function(String value) onSelected;

  const IpAddressListView({
    super.key,
    required this.address,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    // http://192.168.50.131:1234
    return Wrap(
      children: List.generate(
        address.all.length,
        (index) {
          final value = address.all[index];

          return TextButton(
            onPressed: () => onSelected('http://${value.address}:1234'),
            child: Text(
              '${value.type.name} ${value.address}',
            ),
          );
        },
      ),
    );
  }
}
