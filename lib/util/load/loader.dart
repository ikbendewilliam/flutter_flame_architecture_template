import 'package:flutter/cupertino.dart';
// games_services import 'package:games_services/games_services.dart';
// google_mobile_ads import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_flame_architecture_template/model/user/user_data.dart';

@singleton
class Loader {
  var _isInitialized = false;
  var _isLoaded = false;
  final listeners = <LoadingListener>[];

  bool get isLoading => !_isLoaded;

  void addListener(LoadingListener value) => listeners.add(value);

  void removeListener(LoadingListener value) => listeners.remove(value);

  Future<void> load() async {
    if (_isInitialized) return;
    _isInitialized = true;
    _isLoaded = false;
    UserData.initialize();
    Future.wait([
      _tryPlaySignin(),
      // google_mobile_ads MobileAds.instance.initialize(),
    ]);
    _isLoaded = true;
    notifyListeners();
  }

  @protected
  void notifyListeners() {
    listeners.forEach((listener) => listener.onLoadingDone());
  }

  // Note: Gameservices are not available in debug, so we add a try catch
  Future<void> _tryPlaySignin() async {
    try {
      // games_services await GamesServices.signIn();
    } catch (e) {}
  }
}

mixin LoadingListener {
  void onLoadingDone();
}
