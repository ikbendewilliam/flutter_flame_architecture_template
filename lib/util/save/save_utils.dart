import 'dart:convert';
import 'dart:io';

import 'package:cryptography/cryptography.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

@injectable
class SaveUtils {
  static const FILENAME = 'filename';
  static const PREFERENCES_KEY = 'com.template.secret_key';
  static const PREFERENCES_MAC = 'com.template.mac';
  final FlutterSecureStorage _prefs;

  SaveUtils(this._prefs);

  Future<Secret> get _secretKey async {
    if (await _prefs.containsKey(key: PREFERENCES_KEY)) {
      return Secret.fromJson(await _prefs.read(key: PREFERENCES_KEY) ?? '');
    }
    final algorithm = AesGcm.with256bits();
    final secretKey = await algorithm.newSecretKey();
    final nonce = algorithm.newNonce();
    final secret = Secret(secretKey, nonce);
    await _prefs.write(
      key: PREFERENCES_KEY,
      value: await secret.toJson(),
    );
    return secret;
  }

  Future<Mac> get _mac async => Mac(_toBytes(await _prefs.read(key: PREFERENCES_MAC)));

  Future<void> _saveMac(Mac mac) => _prefs.write(key: PREFERENCES_MAC, value: _bytesToString(mac.bytes));

  Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$FILENAME');
  }

  Future<String?> loadFromFile() async {
    final file = await _localFile;
    if (!file.existsSync()) return null;
    final data = await file.readAsBytes();
    return _decryptData(data);
  }

  Future<File> saveToFile(String data) async {
    final file = await _localFile;
    return file.writeAsBytes(await _encryptData(data));
  }

  Future<List<int>> _encryptData(String data) async {
    final secret = await _secretKey;
    final decoded = await AesGcm.with256bits().encrypt(
      data.codeUnits,
      secretKey: secret.secretKey,
      nonce: secret.nonce,
    );
    _saveMac(decoded.mac);
    return decoded.cipherText;
  }

  Future<String> _decryptData(List<int> encrypted) async {
    final secret = await _secretKey;
    return utf8.decode(await AesGcm.with256bits().decrypt(
      SecretBox(encrypted, nonce: secret.nonce, mac: await _mac),
      secretKey: secret.secretKey,
    ));
  }
}

String _bytesToString(List<int> bytes) => bytes.join(',');

List<int> _toBytes(dynamic string) => (string as String).split(',').map(int.parse).toList();

class Secret {
  final SecretKey secretKey;
  final List<int> nonce;

  Secret(this.secretKey, this.nonce);

  Future<Map<String, dynamic>> toMap() async {
    return {
      'secretKey': _bytesToString(await secretKey.extractBytes()),
      'nonce': _bytesToString(nonce),
    };
  }

  factory Secret.fromMap(Map<String, dynamic> map) {
    return Secret(
      SecretKey(_toBytes(map['secretKey'])),
      _toBytes(map['nonce']),
    );
  }

  Future<String> toJson() async => json.encode(await toMap());

  factory Secret.fromJson(String source) => Secret.fromMap(json.decode(source));
}
