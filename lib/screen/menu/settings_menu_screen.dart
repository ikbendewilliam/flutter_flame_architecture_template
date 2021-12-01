import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';
import 'package:flutter_flame_architecture_template/screen/dialog/confirm_dialog.dart';
import 'package:flutter_flame_architecture_template/util/locale/localization.dart';
import 'package:flutter_flame_architecture_template/viewmodel/locale/locale_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_flame_architecture_template/viewmodel/menu/settings_menu_viewmodel.dart';
import 'package:provider/provider.dart';

class SettingsMenuScreen extends FlameWidget {
  static const routeName = 'SettingsMenuScreen';

  Future<void> openSelectLanguageDialog(BuildContext context) async {
    final localeViewModel = Provider.of<LocaleViewModel>(context, listen: false);
    final localization = Localization.of(context);
    await FlameNavigator.showDialog(
      FlameDialog(
        dialogBackground: Colors.black,
        child: FlameColumn(
          children: [
            FlameButton(
              onTap: localeViewModel.onSwitchToEnglish,
              text: localization.settingsLanguageEnglish,
            ),
            FlameButton(
              onTap: localeViewModel.onSwitchToDutch,
              text: localization.settingsLanguageDutch,
            ),
            FlameButton(
              onTap: FlameNavigator.pop,
              text: localization.generalLabelBack,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> resetProgress(BuildContext context, SettingsMenuViewModel viewModel) async {
    final localization = Localization.of(context);
    final confirmed = await FlameNavigator.showDialog(
      ConfirmDialog(
        text: localization.settingsConfirmResetTitle,
        subText: localization.settingsConfirmResetBody,
      ),
    );
    if (confirmed == true) viewModel.resetProgress();
  }

  @override
  FlameWidget build(BuildContext context) {
    final localization = Localization.of(context);
    return FlameChangeNotifierProvider<SettingsMenuViewModel>(
      create: () => GetIt.I()..init(),
      builder: (context, viewModel) => FlameContainer(
        color: Colors.black,
        child: FlameSafeArea(
          child: FlameCenter(
            child: FlameSizedBox(
              width: 256,
              child: FlameColumn(
                children: [
                  FlameSpacer(),
                  FlameButton(
                    child: FlameText(
                      localization.settingsPrimaryColour,
                      color: viewModel.color,
                    ),
                    onTap: viewModel.onColorClicked,
                  ),
                  if (viewModel.isDevToolsEnabled) ...[
                    // FlameButton(
                    //   text: 'unlock something: ${viewModel.unlockSomething ? 'on' : 'off'}',
                    //   onTap: viewModel.toggleUnlockSomething,
                    // ),
                  ],
                  FlameButton(
                    text: localization.settingsResetProgress,
                    onTap: () => resetProgress(context, viewModel),
                  ),
                  FlameButton(
                    text: localization.settingsLanguage,
                    onTap: () => openSelectLanguageDialog(context),
                  ),
                  FlameButton(
                    text: localization.generalLabelBack,
                    onTap: FlameNavigator.pop,
                  ),
                  FlameSpacer(),
                  FlameText(
                    '${viewModel.version} (${viewModel.buildNumber})',
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
