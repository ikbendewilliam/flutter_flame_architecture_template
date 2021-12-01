import 'package:flutter/material.dart';
import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';
import 'package:flutter_flame_architecture_template/util/locale/localization.dart';

class InformationDialog extends FlameWidget {
  final String text;

  InformationDialog({
    required this.text,
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
            FlameSpacer(),
            FlameButton(
              text: localization.generalLabelContinue,
              onTap: FlameNavigator.pop,
            ),
          ],
        ),
      ),
    );
  }
}
