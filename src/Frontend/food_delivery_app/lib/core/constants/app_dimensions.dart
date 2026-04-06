import 'dart:math' as math;

import 'package:flutter/widgets.dart';

final class AppDimensions {
  AppDimensions._();

  static const double designWidth = 402;

  static const double horizontalPadding = 16;
  static const double mediumSpacing = 14;
  static const double largeSpacing = 24;

  static const double headerHeight = 108;
  static const double searchBarHeight = 60;
  static const double infoCardHeight = 60;
  static const double bottomButtonHeight = 80;
  static const double borderRadius = 10;

  static double scaleFor(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final raw = width / designWidth;
    return math.max(0.85, math.min(1.35, raw));
  }

  static double s(BuildContext context, double value) {
    return value * scaleFor(context);
  }
}
