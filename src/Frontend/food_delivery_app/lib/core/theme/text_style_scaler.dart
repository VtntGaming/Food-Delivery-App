import 'package:flutter/material.dart';

TextStyle scaleTextStyle(TextStyle style, double scale) {
  final size = style.fontSize;
  if (size == null) {
    return style;
  }
  return style.copyWith(fontSize: size * scale);
}
