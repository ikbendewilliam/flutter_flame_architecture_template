// firebase_analytics import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';
// firebase_analytics import 'package:get_it/get_it.dart';
import 'package:flutter_flame_architecture_template/model/game_board/game_board_save.dart';
import 'package:flutter_flame_architecture_template/screen/game/game_board_screen.dart';
import 'package:flutter_flame_architecture_template/screen/menu/main_menu_screen.dart';
import 'package:flutter_flame_architecture_template/screen/menu/settings_menu_screen.dart';

class RouteUtil {
  static FlameWidget? onGenerateRoute(RouteSettings settings) {
    // firebase_analytics GetIt.I<FirebaseAnalytics>().setCurrentScreen(screenName: settings.name);
    switch (settings.name) {
      case SettingsMenuScreen.routeName:
        return SettingsMenuScreen();
      case MainMenuScreen.routeName:
        return MainMenuScreen();
      case GameBoardScreen.routeName:
        if (settings.arguments is GameBoardArguments) {
          final arguments = settings.arguments as GameBoardArguments;
          return GameBoardScreen(
            boardSize: arguments.boardSize,
            campaignId: arguments.campaignId,
          );
        } else if (settings.arguments is GameBoardSave) {
          final saveData = settings.arguments as GameBoardSave;
          return GameBoardScreen.load(saveData: saveData);
        } else {
          throw Exception('unclear type of arguments');
        }
      default:
        return null;
    }
  }
}
