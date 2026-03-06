import 'package:flutter/foundation.dart';

sealed class EnvironmentConfig {
  static const EnvironmentFlag showDatabaseInfo = ._hasBool(
    'show-database-info',
    .hasEnvironment('show-database-info'),
  );

  static const EnvironmentConfigFluent has = EnvironmentConfigFluent(true);
  static const EnvironmentConfigFluent hasNot = EnvironmentConfigFluent(false);
}

// Internal wrapper class
final class EnvironmentConfigFluent {
  final bool expected;
  const EnvironmentConfigFluent(this.expected);

  bool get showDatabaseInfo =>
      EnvironmentConfig.showDatabaseInfo.has == expected;
}

final class EnvironmentFlag {
  final String name;
  final bool has;

  bool get hasNot => !has;

  const EnvironmentFlag._hasBool(this.name, this.has);
}

extension BoolOrDebugExt on bool {
  bool get orDebug => this || kDebugMode;
}
