import 'package:flutter/foundation.dart';

sealed class EnvironmentConfig {
  static final EnvironmentFlag showDatabaseInfo = ._hasBool(
    'show-database-info',
  );

  static const EnvironmentConfigFluent has = EnvironmentConfigFluent(true);
  static const EnvironmentConfigFluent hasNot = EnvironmentConfigFluent(false);
}

// Internal wrapper class
final class EnvironmentConfigFluent {
  final bool expected;
  const EnvironmentConfigFluent(this.expected);

  bool get showDatabaseInfo =>
      EnvironmentConfig.showDatabaseInfo._has == expected;
}

final class EnvironmentFlag {
  final String name;
  final bool _has;

  bool get has => _has;
  bool get hasNot => !_has;

  EnvironmentFlag._hasBool(this.name) : _has = .fromEnvironment(name);
}

extension BoolOrDebugExt on bool {
  bool get orDebug => this || kDebugMode;
}
