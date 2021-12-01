import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture_template/screen/dialog/information_dialog.dart';
import 'package:flutter_flame_architecture_template/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';

class UserData {
  static final UserData instance = UserData._();
  static const _USER_DATA_KEY = 'com.template.userdata';
  SharedPreferences? prefs;
  var xp = 0.0;

  UserData._() {
    load();
  }

  static void initialize() async {
    instance; // ignore: unnecessary_statements
  }

  Future<void> load() async {
    prefs ??= await SharedPreferences.getInstance();
    final data = prefs!.getString(_USER_DATA_KEY);
    if (data == null) {
      await Future.delayed(const Duration(seconds: 1)); // Wait untill the first screen is build
      FlameNavigator.showDialog(
        InformationDialog(
          text: 'Enjoy!',
        ),
      );
      save();
      return;
    }
    final json = jsonDecode(data);
    xp = json['xp'] ?? 0.0;
    TemplateTheme.setPrimary(Color(json['primary'] ?? Colors.lime.value));
  }

  Future<void> resetAll() async {
    prefs ??= await SharedPreferences.getInstance();
    prefs!.setString(_USER_DATA_KEY, '{}');
    await load();
  }

  Future<void> save() async {
    prefs ??= await SharedPreferences.getInstance();
    final json = {
      'xp': xp,
    };
    prefs!.setString(_USER_DATA_KEY, jsonEncode(json));
  }
}
