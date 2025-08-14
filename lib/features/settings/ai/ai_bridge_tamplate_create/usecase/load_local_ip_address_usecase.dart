import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:open_words/features/settings/ai/ai_bridge_tamplate_create/models/local_ip_addresses.dart';

class LoadLocalIpAddressUsecase {
  static Future<LocalIpAddresses> invoke() async {
    if (kIsWeb || kIsWasm) {
      return const LocalIpAddresses.empty();
    }

    try {
      List<NetworkInterface> interfaces = await NetworkInterface.list(
        includeLoopback: false,
      );

      return LocalIpAddresses(
        all: interfaces.expand((e) => e.addresses).toList(),
      );
    } catch (e) {
      print('Error getting network info: $e');
    }

    return const LocalIpAddresses.empty();
  }
}
