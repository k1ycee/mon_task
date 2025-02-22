import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static TextTheme get textTheme => TextTheme(
    titleLarge: GoogleFonts.nunitoSans(fontSize: 32.sp),
    titleMedium: GoogleFonts.nunitoSans(fontSize: 28.sp),
    titleSmall: GoogleFonts.nunitoSans(fontSize: 18.sp),
    bodyLarge: GoogleFonts.nunitoSans(fontSize: 16.sp),
    bodyMedium: GoogleFonts.nunitoSans(fontSize: 14.sp),
    bodySmall: GoogleFonts.nunitoSans(fontSize: 12.sp),
    labelLarge: GoogleFonts.nunitoSans(fontSize: 14.sp),
    labelMedium: GoogleFonts.nunitoSans(fontSize: 12.sp),
    labelSmall: GoogleFonts.nunitoSans(fontSize: 10.sp),
  );

  static const ColorScheme light = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xffFCB018),
    onPrimary: Color(0xffffffff),
    primaryContainer: Color(0xffe47510),
    onPrimaryContainer: Color(0xff14100c),
    secondary: Color(0xffB9A480),
    onSecondary: Color(0xffffffff),
    secondaryContainer: Color(0xffca9d7c),
    onSecondaryContainer: Color(0xff110d0b),
    tertiary: Color(0xffef6c00),
    onTertiary: Color(0xffffffff),
    tertiaryContainer: Color(0xffffbe93),
    onTertiaryContainer: Color(0xff14100d),
    error: Color(0xff790000),
    onError: Color(0xffffffff),
    errorContainer: Color(0xfff1d8d8),
    onErrorContainer: Color(0xff141212),
    surface: Color(0xfffafafa),
    onSurface: Color(0xff090909),
    onSurfaceVariant: Color(0xff121211),
    outline: Colors.grey,
    outlineVariant: Color(0xffc8c8c8),
    shadow: Color(0xff000000),
    scrim: Color(0xff000000),
    inverseSurface: Color(0xff151311),
    onInverseSurface: Color(0xfff5f5f5),
    inversePrimary: Color(0xffffe1ad),
    surfaceTint: Color(0xffb86914),
    background: Color(0xfffcdfbd),
    onBackground: Color(0xfffcdfbd),
  );

  static ThemeData lightTheme() => FlexThemeData.light(
        colorScheme: light,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 7,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 10,
          blendOnColors: false,
          useTextTheme: true,
          useM2StyleDividerInM3: true,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
        fontFamily: GoogleFonts.nunitoSans().fontFamily,
        textTheme: textTheme,
      );
}
