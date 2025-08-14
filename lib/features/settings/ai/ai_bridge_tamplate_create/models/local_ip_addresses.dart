import 'dart:io';

class LocalIpAddresses {
  final List<InternetAddress> all;

  bool get isNotEmpty => all.isNotEmpty;

  LocalIpAddresses({
    required this.all,
  });

  const LocalIpAddresses.empty() : all = const [];
}
