import 'package:flutter/material.dart';

class TemplateTheme {
  static final instance = TemplateTheme._();

  TemplateTheme._();

  Color _primary = Colors.lime;
  static Color get primary => instance._primary;

  static setPrimary(Color color) => instance._primary = color;
}
