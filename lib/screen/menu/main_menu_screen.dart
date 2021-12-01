import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';
import 'package:flutter_flame_architecture_template/util/locale/localization.dart';
// games_services import 'package:games_services/games_services.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_flame_architecture_template/screen/game/game_board_screen.dart';
import 'package:flutter_flame_architecture_template/screen/menu/settings_menu_screen.dart';
import 'package:flutter_flame_architecture_template/viewmodel/menu/main_menu_viewmodel.dart';

class MainMenuScreen extends FlameWidget {
  static const routeName = 'MainMenuScreen';

  @override
  FlameWidget build(BuildContext context) {
    final localization = Localization.of(context);
    return FlameChangeNotifierProvider<MainMenuViewModel>(
      create: () => GetIt.I()..init(),
      builder: (context, viewModel) => FlameContainer(
        color: Colors.black,
        child: FlameSafeArea(
          child: FlameRow(
            children: [
              FlameExpanded(
                child: FlameSprite(spriteFileName: 'title.jpg'),
              ),
              FlameExpanded(
                child: FlameColumn(
                  children: [
                    FlameSpacer(),
                    if (viewModel.loading) ...[
                      FlameText(
                        localization.generalLabelLoading,
                        color: Colors.white,
                      ),
                    ] else ...[
                      FlameButton(
                        child: FlameText(
                          localization.menuContinue,
                          color: viewModel.saveGame == null ? Colors.grey : Colors.white,
                        ),
                        onTap: () {
                          if (viewModel.saveGame != null) viewModel.goToScreen(GameBoardScreen.routeName, arguments: viewModel.saveGame!);
                        },
                      ),
                      FlameButton(
                        text: localization.menuSettings,
                        onTap: () => viewModel.goToScreen(SettingsMenuScreen.routeName),
                      ),
                      // games_services FlameButton(
                      // games_services   text: localization.menuAchievements,
                      // games_services   onTap: GamesServices.showAchievements,
                      // games_services ),
                      FlameButton(
                        text: localization.menuCredits,
                        onTap: () => viewModel.showCredits(localization.credits),
                      ),
                    ],
                    FlameSpacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
