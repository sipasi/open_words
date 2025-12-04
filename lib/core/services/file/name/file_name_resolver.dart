import 'package:uuid/uuid.dart';

sealed class FileNameResolver {
  static final _uuid = Uuid();

  static String nameOrUuid(String? name) {
    return name ?? _uuid.v4();
  }
}
