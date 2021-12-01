// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../util/load/loader.dart' as _i4;
import '../util/save/save_utils.dart' as _i6;
import '../viewmodel/menu/main_menu_viewmodel.dart' as _i5;
import '../viewmodel/menu/settings_menu_viewmodel.dart' as _i7;
import 'injectable.dart' as _i8; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final injectableModule = _$InjectableModule();
  gh.singleton<_i3.FlutterSecureStorage>(injectableModule.secureStorage);
  gh.singleton<_i4.Loader>(_i4.Loader());
  gh.factory<_i5.MainMenuViewModel>(
      () => _i5.MainMenuViewModel(get<_i4.Loader>()));
  gh.factory<_i6.SaveUtils>(
      () => _i6.SaveUtils(get<_i3.FlutterSecureStorage>()));
  gh.factory<_i7.SettingsMenuViewModel>(() => _i7.SettingsMenuViewModel());
  return get;
}

class _$InjectableModule extends _i8.InjectableModule {}
