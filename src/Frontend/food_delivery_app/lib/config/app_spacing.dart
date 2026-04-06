import 'package:flutter/material.dart';

/// Centralizes all app spacing values for consistent layout.
abstract class AppSpacing {
  static const double xxxs = 2.0;
  static const double xxs = 4.0;
  static const double xs = 6.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 14.0;
  static const double xl = 16.0;
  static const double xxl = 20.0;
  static const double xxxl = 24.0;
  static const double huge = 32.0;
  static const double massive = 40.0;

  // Pre-defined layout values from Figma
  static const double screenHorizontal = 17.0;
  static const double cardRadius = 12.0;
  static const double bottomNavHeight = 80.0;
  static const double bottomNavRadius = 20.0;
  static const double searchBarHeight = 48.0;
  static const double bottomNavIconSize = 46.0;
  static const double foodCardHeight = 95.0;
  static const double restaurantCardHeight = 63.0;
  static const double bannerHeight = 137.0;
  static const double detailHeaderHeight = 206.0;
  static const double avatarSize = 83.0;
  static const double smallIconSize = 24.0;
  static const double addButtonSize = 24.0;
}

/// Common border radius values used throughout the app.
abstract class AppRadius {
  static const BorderRadius cardRadius = BorderRadius.all(Radius.circular(12.0));
  static const BorderRadius bottomNavRadius = BorderRadius.only(
    topLeft: Radius.circular(20.0),
    topRight: Radius.circular(20.0),
  );
  static const BorderRadius searchBarRadius = BorderRadius.all(Radius.circular(12.0));
}
