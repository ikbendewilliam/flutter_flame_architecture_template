import 'dart:math';

// firebase_analytics import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';
// firebase_analytics import 'package:get_it/get_it.dart';
import 'package:flutter_flame_architecture_template/model/game_board/game_board_save.dart';
import 'package:flutter_flame_architecture_template/model/game_board/game_board_ui_state.dart';
import 'package:flutter_flame_architecture_template/model/user/user_data.dart';
import 'package:flutter_flame_architecture_template/screen/game/game_board_screen.dart';
import 'package:flutter_flame_architecture_template/screen/game/game_board_pause_dialog.dart';
// firebase_analytics import 'package:flutter_flame_architecture_template/util/data/analytics.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameBoardViewModel {
  static const SAVE_GAME_KEY = 'com.template.savegame';
  late final SharedPreferences preferences;

  final Vector2 boardSize;
  final userMoney = ValueNotifier<double>(0);
  final speedMultiplier = ValueNotifier<double>(1);
  final String? campaignId;
  final random = Random();

  VoidCallback? markUIForRebuild;
  var _shouldRebuild = false;
  var _uiState = GameBoardUIState.Default;

  GameBoardUIState get uiState => _uiState;

  GameBoardViewModel({
    required this.boardSize,
    this.campaignId,
  }) {
    SharedPreferences.getInstance().then((value) => preferences = value);
    SystemChannels.lifecycle.setMessageHandler((msg) async {
      if (msg == AppLifecycleState.paused.toString()) save();
    });
  }

  GameBoardViewModel.load(GameBoardSave saveData)
      : campaignId = saveData.campaignId,
        boardSize = saveData.boardSize {
    SharedPreferences.getInstance().then((value) => preferences = value);
  }

  Future<void> save() async {
    await preferences.setString(
      SAVE_GAME_KEY,
      GameBoardSave(
        campaignId: campaignId,
        boardSize: boardSize,
      ).toJson(),
    );
  }

  Future<void> update(double delta) async {
    delta *= speedMultiplier.value;
    if (_shouldRebuild) {
      markUIForRebuild?.call();
      _shouldRebuild = false;
    }
    _endGame(won: true);
  }

  Future<void> _endGame({required bool won}) async {
    preferences.remove(SAVE_GAME_KEY);
    var xpWon = 1;
    if (campaignId != null && won) {
      UserData.instance.xp += xpWon;
      UserData.instance.save();
    }
    // firebase_analytics GetIt.I<FirebaseAnalytics>().logEvent(name: won ? Analytics.GameWon : Analytics.GameLost, parameters: {Analytics.Level: campaignId});
    FlameNavigator.popUntil(
      (route) => route.routeSettings.name != GameBoardScreen.routeName,
      result: GameBoardResult(
        won: won,
      ),
    );
  }

  bool isOutside(Vector2 position) => (boardSize.x <= position.x || boardSize.y <= position.y || position.x < 0 || position.y < 0);

  double abs(double value) {
    return (value >= 0) ? value : -value;
  }

  void setSpeed(double speed) {
    speedMultiplier.value = speed;
  }

  void onSpeedClicked() {
    _uiState = GameBoardUIState.Speed;
    _shouldRebuild = true;
  }

  void onBackClicked() {
    _shouldRebuild = true;
  }

  Future<void> onPauseClicked() async {
    save();
    await FlameNavigator.showDialog(GameBoardPauseDialog());
  }
}
