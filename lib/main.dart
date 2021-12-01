import 'dart:async';

// firebase_core import 'package:firebase_core/firebase_core.dart';
// firebase_crashlytics import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture_template/repository/locale/locale_repository.dart';
import 'package:flutter_flame_architecture_template/util/locale/localization_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';
import 'package:flutter_flame_architecture_template/di/injectable.dart';
import 'package:flutter_flame_architecture_template/screen/menu/main_menu_screen.dart';
import 'package:flutter_flame_architecture_template/util/route/route_util.dart';
import 'package:flutter_flame_architecture_template/viewmodel/locale/locale_viewmodel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // firebase_crashlytics runZonedGuarded<Future<void>>(() async {
  await Future.wait([
    // firebase_crashlytics Firebase.initializeApp(),
    configureDependencies(),
  ]);
  // firebase_crashlytics FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  runApp(
    ChangeNotifierProvider<LocaleViewModel>(
      create: (context) => LocaleViewModel(LocaleRepository())..init(),
      child: Consumer<LocaleViewModel>(
        builder: (context, value, child) => MaterialApp(
          localizationsDelegates: [
            value.localeDelegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          locale: value.localeDelegate.activeLocale,
          supportedLocales: LocalizationDelegate.supportedLocales,
          home: WillPopScope(
            onWillPop: () async {
              FlameNavigator.pop();
              return false;
            },
            child: TemplateGameWidget(),
          ),
        ),
      ),
    ),
  );
  setFullScreen();
  // firebase_crashlytics }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

class TemplateGameWidget extends StatefulWidget {
  @override
  State<TemplateGameWidget> createState() => _TemplateGameWidgetState();
}

class _TemplateGameWidgetState extends State<TemplateGameWidget> {
  LocaleViewModel? _localeViewModel;

  @override
  void dispose() {
    _localeViewModel?.removeListener(markForRebuild);
    _localeViewModel = null;
    super.dispose();
  }

  void markForRebuild() {
    print('hi');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_localeViewModel == null) {
      _localeViewModel = Provider.of<LocaleViewModel>(context, listen: false);
      _localeViewModel!.addListener(markForRebuild);
    }
    return GameWidget(
      game: SimpleGameManager(
        initialRoute: MainMenuScreen.routeName,
        onGenerateRoute: RouteUtil.onGenerateRoute,
      ),
    );
  }
}

Future<void> setFullScreen() async {
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();
}
