import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorage {
  Future<String?> read(String key);

  Future<bool> containsKey(String key);

  Future write({required String key, required String value});

  Future delete(String key);
}

final class SecureStorageImpl extends SecureStorage {
  final FlutterSecureStorage storage;

  SecureStorageImpl._(this.storage);

  factory SecureStorageImpl() {
    final storage = FlutterSecureStorage(
      aOptions: const AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    );

    return SecureStorageImpl._(storage);
  }

  @override
  Future<bool> containsKey(String key) => storage.containsKey(key: key);

  @override
  Future<String?> read(String key) => storage.read(key: key);
  @override
  Future write({required String key, required String value}) =>
      storage.write(key: key, value: value);

  @override
  Future delete(String key) => storage.delete(key: key);
}
