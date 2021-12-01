import 'package:flutter/cupertino.dart';

mixin DisposeMixin on ChangeNotifier {
  bool disposed = false;

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }
}
