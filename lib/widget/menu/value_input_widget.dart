import 'package:flutter/cupertino.dart';
import 'package:flutter_flame_architecture/flutter_flame_architecture.dart';

class ValueInputWidget extends FlameWidget {
  final VoidCallback reduce;
  final VoidCallback increase;
  final ValueNotifier<dynamic> notifier;
  final String label;

  ValueInputWidget({
    required this.reduce,
    required this.increase,
    required this.notifier,
    required this.label,
  });

  @override
  FlameWidget build(BuildContext context) {
    return FlameSizedBox(
      height: 32,
      child: FlameRow(
        children: [
          FlameSpacer(),
          FlameButton(
            text: '-',
            width: 32,
            onTap: reduce,
          ),
          FlameSizedBox(
            height: 32,
            width: 128,
            child: FlameValueListenableBuilder<dynamic>(
              valueListenable: notifier,
              builder: (context, value, _) => FlameButton(
                text: '$label: $value',
                onTap: () {},
                width: 128,
              ),
            ),
          ),
          FlameButton(
            text: '+',
            width: 32,
            onTap: increase,
          ),
          FlameSpacer(),
        ],
      ),
    );
  }
}
