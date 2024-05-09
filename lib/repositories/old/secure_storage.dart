import 'package:flutter_secure_storage/flutter_secure_storage.dart';

mixin SecureStorage {
  static const _storage = FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await _storage.write(key: 'token', value: token);
  }

  Future<String?> getToken() {
    return  _storage.read(key: 'token');
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: 'token');
  }
}