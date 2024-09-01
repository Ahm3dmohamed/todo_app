import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/modules/core/themes/app_color.dart';

class Apptheme {
  static const Color light = Colors.white;
  static const Color lightPrimary = Color(0xFF5D9CEC);
  static const Color darkPrimary = Color(0xFF141922);
  static final Color darkSplash = const Color(0xff060E1E);

  ThemeData isDark = darkTheme;
  static ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: Apptheme.lightPrimary,
      elevation: 0,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
    ),
    fontFamily: GoogleFonts.poppins().fontFamily,
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.normal,
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.normal,
      ),
      bodySmall: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.normal,
        // fontFamily: 'Qran'
      ),
      bodyMedium: TextStyle(
        color: Color(0xFF141922),
        fontSize: 20,
        fontWeight: FontWeight.normal,
        // fontFamily: 'Qran'
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      showSelectedLabels: true,
      showUnselectedLabels: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      selectedItemColor: AppColor.primaryColor,
      unselectedItemColor: Colors.white,
      // backgroundColor: Apptheme.light,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Apptheme.light,
    ),
    datePickerTheme: const DatePickerThemeData(
      backgroundColor: Apptheme.light,
    ),
    scaffoldBackgroundColor: Apptheme.light,
    splashColor: Apptheme.light,
  );

  static ThemeData darkTheme = ThemeData(
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4), // Rounded corners
        side: const BorderSide(
          color: Color(0xFF5D9CEC), // Border color
          width: 4, // Border width
        ),
      ),
      backgroundColor: const Color(0xFF141922), // Background color
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 4, 48, 105),
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
    ),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.normal,
      ),
      bodySmall: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.normal,
        // fontFamily: 'Qran'
      ),
      bodyMedium: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.normal,
        // fontFamily: 'Qran'
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      showSelectedLabels: true,
      showUnselectedLabels: false,
      backgroundColor: Color(0xff141922),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Apptheme.darkPrimary,
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: Apptheme.darkPrimary,
    ),
    scaffoldBackgroundColor: Apptheme.darkSplash,
    splashColor: Apptheme.darkPrimary,
  );
}
