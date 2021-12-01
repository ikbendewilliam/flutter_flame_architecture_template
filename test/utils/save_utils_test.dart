import 'dart:convert';

import 'package:flutter_flame_architecture_template/di/injectable.dart';
import 'package:flutter_flame_architecture_template/util/save/save_utils.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() async {
    configureDependencies();
  });

  test('Test save to file', () async {
    final test = 'test';
    final saveUtils = SaveUtils(MockFlutterSecureStorage());
    final file = await saveUtils.saveToFile(test);
    final data = await file.readAsBytes();
    try {
      print(utf8.decode(data));
    } catch (e) {
      print('couldn\'t decode file, contents: $data');
    }
    final test2 = await saveUtils.loadFromFile();
    expect(test, test2);
  });
}

class MockFlutterSecureStorage extends FlutterSecureStorage {
  Map<String, String?> values = {};

  @override
  Future<void> write({
    required String key,
    required String? value,
    IOSOptions? iOptions = IOSOptions.defaultOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
  }) async =>
      values[key] = value;

  @override
  Future<String?> read({
    required String key,
    IOSOptions? iOptions = IOSOptions.defaultOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
  }) async =>
      values[key];

  @override
  Future<bool> containsKey({
    required String key,
    IOSOptions? iOptions = IOSOptions.defaultOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
  }) async =>
      values.containsKey(key);
}
