import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';
import 'package:flutter_flame_architecture_template/util/locale/localization.dart';

class GameBoardFinishedDialog extends FlameWidget {
  final bool won;
  final int? xpWon;
  final bool canBuySkill;

  GameBoardFinishedDialog({
    required this.won,
    this.xpWon,
    this.canBuySkill = false,
  });

  @override
  FlameWidget build(BuildContext context) {
    final localization = Localization.of(context);
    return FlameDialog(
      dialogBackground: Colors.black,
      closeOnPressOutside: false,
      child: FlameColumn(
        children: [
          FlameSpacer(),
          FlameText(
            won ? localization.gameWon : localization.gameLost,
            color: Colors.white,
          ),
          if (xpWon != null && xpWon! > 0) ...[
            FlameSizedBox(height: 10),
            FlameText(
              localization.gameEarnedXp(xpWon!),
              color: Colors.white,
            ),
          ],
          FlameButton(
            onTap: FlameNavigator.pop,
            text: 'Quit',
          ),
        ],
      ),
    );
  }
}
