// firebase_analytics import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_flame_architecture_template/di/injectable.config.dart';

@InjectableInit(
  initializerName: r'$initGetIt',
  generateForDir: ['lib'],
)
Future<void> configureDependencies([String? environment]) async {
  $initGetIt(GetIt.instance, environment: environment);
  await GetIt.instance.allReady();
}

@module
abstract class InjectableModule {
  // firebase_analytics @singleton
  // firebase_analytics FirebaseAnalytics get analytics => FirebaseAnalytics();

  @singleton
  FlutterSecureStorage get secureStorage => FlutterSecureStorage();
}
