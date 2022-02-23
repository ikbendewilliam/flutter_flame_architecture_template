import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_flame_architecture_template/model/user/user_data.dart';
import 'package:flutter_flame_architecture_template/theme/theme.dart';
import 'package:package_info/package_info.dart';

@injectable
class SettingsMenuViewModel extends ChangeNotifier {
  late final UserData _userData;

  Color get color => TemplateTheme.primary;

  String version = '';
  String buildNumber = '';

  final colorOptions = Colors.primaries.map((e) => e.shade500.value).toList();

  bool get isDevToolsEnabled => false;

  Future<void> init() async {
    _userData = UserData.instance;
    notifyListeners();
    final packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
    notifyListeners();
  }

  void onColorClicked() {
    final index = (colorOptions.indexOf(TemplateTheme.primary.value) + 1) % colorOptions.length;
    TemplateTheme.setPrimary(Color(colorOptions[index]));
    notifyListeners();
    UserData.instance.save();
  }

  Future<void> resetProgress() async {
    await _userData.resetAll();
    notifyListeners();
  }
}
