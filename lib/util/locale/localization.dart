import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_flame_architecture_template/util/locale/localization_keys.dart';
import 'package:flutter_flame_architecture_template/util/locale/localization_overrides.dart';

//============================================================//
//THIS FILE IS AUTO GENERATED. DO NOT EDIT//
//============================================================//
class Localization {
  var _localisedValues = <String, dynamic>{};
  var _localisedOverrideValues = <String, dynamic>{};

  static Localization of(BuildContext context) => Localizations.of<Localization>(context, Localization)!;

  /// The locale is used to get the correct json locale.
  /// It can later be used to check what the locale is that was used to load this Localization instance.
  final Locale locale;

  Localization({required this.locale});

  static Future<Localization> load(Locale locale, {
    LocalizationOverrides? localizationOverrides,
    bool showLocalizationKeys = false,
    bool useCaching = true,
    }) async {
    final localizations = Localization(locale: locale);
    if (showLocalizationKeys) {
      return localizations;
    }
    if (localizationOverrides != null) {
      final overrideLocalizations = await localizationOverrides.getOverriddenLocalizations(locale);
      localizations._localisedOverrideValues = overrideLocalizations;
    }
    final jsonContent = await rootBundle.loadString('assets/locale/${locale.languageCode}.json', cache: useCaching);
    localizations._localisedValues = json.decode(jsonContent) as Map<String, dynamic>; // ignore: avoid_as
    return localizations;
  }

  String _t(String key, {List<dynamic>? args}) {
    try {
      final value = (_localisedOverrideValues[key] ?? _localisedValues[key]) as String?;
      if (value == null) return key;
      if (args == null || args.isEmpty) return value;
      var newValue = value;
      // ignore: avoid_annotating_with_dynamic
      args.asMap().forEach((index, dynamic arg) => newValue = _replaceWith(newValue, arg, index + 1));
      return newValue;
    } catch (e) {
      return '⚠$key⚠';
    }
  }

  String _replaceWith(String value, Object? arg, int argIndex) {
    if (arg == null) return value;
    if (arg is String) {
      return value.replaceAll('%$argIndex\$s', arg);
    } else if (arg is num) {
      return value.replaceAll('%$argIndex\$d', '$arg');
    }
    return value;
  }

  /// Translations:
  ///
  /// en:  **'Developed by WiVe (William Verhaeghe)\nwive.be'**
  ///
  /// nl:  **'Gemaakt door WiVe (William Verhaeghe)\nwive.be'**
  String get credits => _t(LocalizationKeys.credits);

  /// Translations:
  ///
  /// en:  **'Continue'**
  ///
  /// nl:  **'Volgende'**
  String get generalLabelContinue => _t(LocalizationKeys.generalLabelContinue);

  /// Translations:
  ///
  /// en:  **'Quit'**
  ///
  /// nl:  **'Stop'**
  String get generalLabelQuit => _t(LocalizationKeys.generalLabelQuit);

  /// Translations:
  ///
  /// en:  **'Loading...'**
  ///
  /// nl:  **'Laden...'**
  String get generalLabelLoading => _t(LocalizationKeys.generalLabelLoading);

  /// Translations:
  ///
  /// en:  **'Yes'**
  ///
  /// nl:  **'Ja'**
  String get generalLabelYes => _t(LocalizationKeys.generalLabelYes);

  /// Translations:
  ///
  /// en:  **'No'**
  ///
  /// nl:  **'Nee'**
  String get generalLabelNo => _t(LocalizationKeys.generalLabelNo);

  /// Translations:
  ///
  /// en:  **'Back'**
  ///
  /// nl:  **'Terug'**
  String get generalLabelBack => _t(LocalizationKeys.generalLabelBack);

  /// Translations:
  ///
  /// en:  **'Continue'**
  ///
  /// nl:  **'Verder spelen'**
  String get menuContinue => _t(LocalizationKeys.menuContinue);

  /// Translations:
  ///
  /// en:  **'Settings'**
  ///
  /// nl:  **'Instellingen'**
  String get menuSettings => _t(LocalizationKeys.menuSettings);

  /// Translations:
  ///
  /// en:  **'Achievements'**
  ///
  /// nl:  **'Achievements'**
  String get menuAchievements => _t(LocalizationKeys.menuAchievements);

  /// Translations:
  ///
  /// en:  **'Credits'**
  ///
  /// nl:  **'Credits'**
  String get menuCredits => _t(LocalizationKeys.menuCredits);

  /// Translations:
  ///
  /// en:  **'You won!'**
  ///
  /// nl:  **'Je bent gewonnen!'**
  String get gameWon => _t(LocalizationKeys.gameWon);

  /// Translations:
  ///
  /// en:  **'You lost!'**
  ///
  /// nl:  **'Je bent verloren!'**
  String get gameLost => _t(LocalizationKeys.gameLost);

  /// Translations:
  ///
  /// en:  **'And gained [arg1 number] xp'**
  ///
  /// nl:  **'en krijgt [arg1 number] xp'**
  String gameEarnedXp(num arg1) => _t(LocalizationKeys.gameEarnedXp, args: <dynamic>[arg1]);

  /// Translations:
  ///
  /// en:  **'Are you sure?'**
  ///
  /// nl:  **'Ben je zeker?'**
  String get settingsConfirmResetTitle => _t(LocalizationKeys.settingsConfirmResetTitle);

  /// Translations:
  ///
  /// en:  **'This will reset all progress, you will get nothing in return.'**
  ///
  /// nl:  **'Al je vooruitgang wordt gereset en je krijgt hiervoor niets terug.'**
  String get settingsConfirmResetBody => _t(LocalizationKeys.settingsConfirmResetBody);

  /// Translations:
  ///
  /// en:  **'Primary colour'**
  ///
  /// nl:  **'Hoofdkleur'**
  String get settingsPrimaryColour => _t(LocalizationKeys.settingsPrimaryColour);

  /// Translations:
  ///
  /// en:  **'Reset progress'**
  ///
  /// nl:  **'Spel resetten'**
  String get settingsResetProgress => _t(LocalizationKeys.settingsResetProgress);

  /// Translations:
  ///
  /// en:  **'Language'**
  ///
  /// nl:  **'Taal'**
  String get settingsLanguage => _t(LocalizationKeys.settingsLanguage);

  /// Translations:
  ///
  /// en:  **'Nederlands'**
  ///
  /// nl:  **'Nederlands'**
  String get settingsLanguageDutch => _t(LocalizationKeys.settingsLanguageDutch);

  /// Translations:
  ///
  /// en:  **'English'**
  ///
  /// nl:  **'English'**
  String get settingsLanguageEnglish => _t(LocalizationKeys.settingsLanguageEnglish);

  String getTranslation(String key, {List<dynamic>? args}) => _t(key, args: args ?? <dynamic>[]);

}
