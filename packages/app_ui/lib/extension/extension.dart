import 'package:flutter/material.dart';

extension AppTextTheme on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}
