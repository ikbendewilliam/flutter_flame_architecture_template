import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';
import 'package:flutter_flame_architecture_template/util/locale/localization.dart';

class ConfirmDialog extends FlameWidget {
  final String text;
  final String subText;

  ConfirmDialog({
    required this.text,
    required this.subText,
  });

  @override
  FlameWidget build(BuildContext context) {
    final localization = Localization.of(context);
    return FlameDialog(
      height: 256,
      padding: const EdgeInsets.all(4),
      child: FlameContainer(
        color: Colors.black,
        child: FlameColumn(
          children: [
            FlameSpacer(),
            FlameText(
              text,
              color: Colors.white,
            ),
            FlameSizedBox(height: 8),
            FlameText(
              subText,
              color: Colors.white,
            ),
            FlameSpacer(),
            FlameButton(
              text: localization.generalLabelYes,
              onTap: () => FlameNavigator.pop(result: true),
            ),
            FlameSizedBox(height: 2),
            FlameButton(
              text: localization.generalLabelNo,
              onTap: () => FlameNavigator.pop(result: false),
            ),
          ],
        ),
      ),
    );
  }
}
