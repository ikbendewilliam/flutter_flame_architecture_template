import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_flame_architecture_template/model/game_board/game_board_save.dart';
import 'package:flutter_flame_architecture_template/screen/dialog/information_dialog.dart';
import 'package:flutter_flame_architecture_template/util/load/loader.dart';
import 'package:flutter_flame_architecture_template/util/mixin/dispose_mixin.dart';
import 'package:flutter_flame_architecture_template/viewmodel/game/game_board_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class MainMenuViewModel extends ChangeNotifier with DisposeMixin, LoadingListener {
  GameBoardSave? _saveGame;
  late final SharedPreferences prefs;
  final Loader loader;
  var _loading = true;

  bool get loading => _loading;

  GameBoardSave? get saveGame => _saveGame;

  MainMenuViewModel(this.loader);

  Future<void> init() async {
    loader.addListener(this);
    loader.load();
    _loading = loader.isLoading;
    notifyListeners();
    prefs = await SharedPreferences.getInstance();
    if (disposed) return;
    await _checkSave();
  }

  @override
  void dispose() {
    loader.removeListener(this);
    super.dispose();
  }

  Future<void> _checkSave() async {
    final save = prefs.getString(GameBoardViewModel.SAVE_GAME_KEY);
    if (save != null) {
      _saveGame = GameBoardSave.fromJson(save);
    } else {
      _saveGame = null;
    }
    if (!disposed) notifyListeners();
  }

  Future<void> goToScreen(String route, {dynamic arguments}) async {
    await FlameNavigator.pushNamed(route, arguments: arguments);
    _checkSave();
  }

  void showCredits(String credits) {
    FlameNavigator.showDialog(InformationDialog(text: credits));
  }

  @override
  void onLoadingDone() {
    _loading = false;
    notifyListeners();
  }
}
