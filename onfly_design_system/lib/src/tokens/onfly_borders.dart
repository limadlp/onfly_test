import 'package:flutter/material.dart';

class OnflyBorders {
  static const double radiusNone = 0.0;
  static const double radiusSm = 4.0;
  static const double radiusMd = 8.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;
  static const double radiusCircular = 100.0;

  static BorderRadius get smallRadius => BorderRadius.circular(radiusSm);
  static BorderRadius get mediumRadius => BorderRadius.circular(radiusMd);
  static BorderRadius get largeRadius => BorderRadius.circular(radiusLg);
  static BorderRadius get extraLargeRadius => BorderRadius.circular(radiusXl);
  static BorderRadius get circularRadius =>
      BorderRadius.circular(radiusCircular);
}

class OnflyShadows {
  static List<BoxShadow> get sm => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.05),
      blurRadius: 4,
      offset: const Offset(0, 1),
    ),
  ];

  static List<BoxShadow> get md => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.07),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> get lg => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.1),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ];
}
