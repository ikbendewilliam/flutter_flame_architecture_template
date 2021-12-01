import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';
import 'package:flutter_flame_architecture_template/util/locale/localization.dart';

class GameBoardPauseDialog extends FlameWidget {
  @override
  FlameWidget build(BuildContext context) {
    final localization = Localization.of(context);
    return FlameDialog(
      dialogBackground: Colors.black,
      child: FlameColumn(
        children: [
          FlameSpacer(),
          FlameButton(
            onTap: () {
              FlameNavigator.pop();
            },
            text: localization.generalLabelContinue,
          ),
          FlameButton(
            onTap: () {
              FlameNavigator.pop();
              FlameNavigator.pop();
            },
            text: localization.generalLabelQuit,
          ),
        ],
      ),
    );
  }
}
