import 'package:flutter/material.dart';
import 'package:onfly_design_system/onfly_design_system.dart';

class OnflyTheme {
  static ThemeData get light {
    return ThemeData(
      primaryColor: OnflyColors.primary,
      scaffoldBackgroundColor: OnflyColors.background,
      colorScheme: ColorScheme.light(
        primary: OnflyColors.primary,
        secondary: OnflyColors.secondary,
        surface: OnflyColors.white,
        //background: OnflyColors.background,
        error: OnflyColors.alert,
      ),
      textTheme: TextTheme(
        displayLarge: OnflyTypography.titleXL,
        displayMedium: OnflyTypography.titleLG,
        displaySmall: OnflyTypography.titleMD,
        headlineMedium: OnflyTypography.titleSM,
        bodyLarge: OnflyTypography.bodyLG,
        bodyMedium: OnflyTypography.bodyMD,
        bodySmall: OnflyTypography.bodySM,
        labelLarge: OnflyTypography.label,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: OnflyColors.white,
        elevation: 0,
        titleTextStyle: OnflyTypography.titleMD.copyWith(
          color: OnflyColors.secondary,
        ),
        iconTheme: IconThemeData(color: OnflyColors.secondary),
      ),
      cardTheme: CardTheme(
        color: OnflyColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: OnflyBorders.largeRadius,
          side: BorderSide(color: OnflyColors.gray200, width: 1),
        ),
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: OnflyColors.white,
        contentPadding: EdgeInsets.all(OnflySpacings.inputPadding),
        border: OutlineInputBorder(
          borderRadius: OnflyBorders.mediumRadius,
          borderSide: BorderSide(color: OnflyColors.gray200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: OnflyBorders.mediumRadius,
          borderSide: BorderSide(color: OnflyColors.gray200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: OnflyBorders.mediumRadius,
          borderSide: BorderSide(color: OnflyColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: OnflyBorders.mediumRadius,
          borderSide: BorderSide(color: OnflyColors.alert, width: 1),
        ),
        labelStyle: OnflyTypography.label.copyWith(color: OnflyColors.gray600),
        hintStyle: OnflyTypography.bodyMD.copyWith(color: OnflyColors.gray400),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: OnflyColors.primary,
          foregroundColor: OnflyColors.white,
          padding: EdgeInsets.symmetric(
            horizontal: OnflySpacings.buttonPaddingHorizontal,
            vertical: OnflySpacings.buttonPaddingVertical,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: OnflyBorders.mediumRadius,
          ),
          textStyle: OnflyTypography.bodyLG.copyWith(
            fontWeight: FontWeight.w500,
          ),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: OnflyColors.primary,
          side: BorderSide(color: OnflyColors.primary),
          padding: EdgeInsets.symmetric(
            horizontal: OnflySpacings.buttonPaddingHorizontal,
            vertical: OnflySpacings.buttonPaddingVertical,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: OnflyBorders.mediumRadius,
          ),
          textStyle: OnflyTypography.bodyLG.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: OnflyColors.white,
        selectedItemColor: OnflyColors.primary,
        unselectedItemColor: OnflyColors.gray500,
        selectedLabelStyle: OnflyTypography.bodySM.copyWith(
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: OnflyTypography.bodySM,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      primaryColor: OnflyColors.primary,
      scaffoldBackgroundColor: OnflyColors.gray900,
      colorScheme: ColorScheme.dark(
        primary: OnflyColors.primary,
        secondary: OnflyColors.secondary,
        surface: OnflyColors.gray800,
        //background: OnflyColors.gray900,
        error: OnflyColors.alert,
      ),
      textTheme: TextTheme(
        displayLarge: OnflyTypography.titleXL.copyWith(
          color: OnflyColors.white,
        ),
        displayMedium: OnflyTypography.titleLG.copyWith(
          color: OnflyColors.white,
        ),
        displaySmall: OnflyTypography.titleMD.copyWith(
          color: OnflyColors.white,
        ),
        headlineMedium: OnflyTypography.titleSM.copyWith(
          color: OnflyColors.white,
        ),
        bodyLarge: OnflyTypography.bodyLG.copyWith(color: OnflyColors.white),
        bodyMedium: OnflyTypography.bodyMD.copyWith(color: OnflyColors.white),
        bodySmall: OnflyTypography.bodySM.copyWith(color: OnflyColors.white),
        labelLarge: OnflyTypography.label.copyWith(color: OnflyColors.white),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: OnflyColors.gray800,
        elevation: 0,
        titleTextStyle: OnflyTypography.titleMD.copyWith(
          color: OnflyColors.white,
        ),
        iconTheme: IconThemeData(color: OnflyColors.white),
      ),
      cardTheme: CardTheme(
        color: OnflyColors.gray800,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: OnflyBorders.largeRadius,
          side: BorderSide(color: OnflyColors.gray700, width: 1),
        ),
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: OnflyColors.gray800,
        contentPadding: EdgeInsets.all(OnflySpacings.inputPadding),
        border: OutlineInputBorder(
          borderRadius: OnflyBorders.mediumRadius,
          borderSide: BorderSide(color: OnflyColors.gray700),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: OnflyBorders.mediumRadius,
          borderSide: BorderSide(color: OnflyColors.gray700),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: OnflyBorders.mediumRadius,
          borderSide: BorderSide(color: OnflyColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: OnflyBorders.mediumRadius,
          borderSide: BorderSide(color: OnflyColors.alert, width: 1),
        ),
        labelStyle: OnflyTypography.label.copyWith(color: OnflyColors.gray300),
        hintStyle: OnflyTypography.bodyMD.copyWith(color: OnflyColors.gray500),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: OnflyColors.primary,
          foregroundColor: OnflyColors.white,
          padding: EdgeInsets.symmetric(
            horizontal: OnflySpacings.buttonPaddingHorizontal,
            vertical: OnflySpacings.buttonPaddingVertical,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: OnflyBorders.mediumRadius,
          ),
          textStyle: OnflyTypography.bodyLG.copyWith(
            fontWeight: FontWeight.w500,
          ),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: OnflyColors.primary,
          side: BorderSide(color: OnflyColors.primary),
          padding: EdgeInsets.symmetric(
            horizontal: OnflySpacings.buttonPaddingHorizontal,
            vertical: OnflySpacings.buttonPaddingVertical,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: OnflyBorders.mediumRadius,
          ),
          textStyle: OnflyTypography.bodyLG.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: OnflyColors.gray800,
        selectedItemColor: OnflyColors.primary,
        unselectedItemColor: OnflyColors.gray400,
        selectedLabelStyle: OnflyTypography.bodySM.copyWith(
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: OnflyTypography.bodySM,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }
}
