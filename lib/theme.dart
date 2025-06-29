import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gowagr_assessment/utils/assets/colors.dart';
import 'package:gowagr_assessment/utils/assets/fontStyle.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      textTheme: GoogleFonts.archivoTextTheme(Theme.of(context).textTheme)
          .copyWith(
            titleLarge: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
      fontFamily: AppFontFam.appFontStyle.fontFamily,
      colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
      useMaterial3: true,

      chipTheme: ChipThemeData(
        selectedColor: primaryColor,
        elevation: 0,
        showCheckmark: false,
        disabledColor: liteGreyColor,
        backgroundColor: liteGreyColor,
        shape: RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.circular(4),
        ),
        side: BorderSide.none,
      ),
      tabBarTheme: TabBarThemeData(
        dividerHeight: 0,
        labelPadding: const EdgeInsets.only(right: 30),
        indicatorSize: TabBarIndicatorSize.label,
        unselectedLabelStyle: AppFontFam.appFontStyle.copyWith(
          color: tertiaryTextColor,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        labelStyle: AppFontFam.appFontStyle.copyWith(
          color: secondaryColor,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        indicator: ShapeDecoration(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        overlayColor: WidgetStatePropertyAll(WidgetStateColor.transparent),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: Colors.white,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: BorderSide(color: liteGreyColor, width: 1.5),
        ),
      ),
    );
  }
}
