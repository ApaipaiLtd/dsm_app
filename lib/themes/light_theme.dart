import 'package:dsm_app/themes/app_theme.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  extensions: [
    AppTheme(primaryColor: Colors.red, placeholderColor: Color(0xff7E7E7E)),
  ],
  primaryColor: Colors.black,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    titleTextStyle: TextStyle(color: Color(0xff333333), fontSize: 16),
    iconTheme: IconThemeData(
      color: Color(0xff7E7E7E),
    ),
    centerTitle: true,
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionHandleColor: Colors.black,
    selectionColor: Colors.black38,
  ),
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: Colors.white30,
    shadowColor: Colors.transparent,
    elevation: 0,
  ),
  dialogTheme: DialogTheme(
    actionsPadding: EdgeInsets.fromLTRB(20, 0, 20, 20),
  ),
  // iconTheme: IconThemeData(
  //   color: Colors.black,
  // ),
  inputDecorationTheme: InputDecorationTheme(
    isDense: true,
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50)), gapPadding: 0, borderSide: BorderSide(color: Colors.black26)),
    outlineBorder: BorderSide(color: Colors.black26),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black), borderRadius: BorderRadius.all(Radius.circular(50)), gapPadding: 0),
    iconColor: Colors.black,
    suffixIconColor: Color(0xff7E7E7E),
  ),
  scaffoldBackgroundColor: Colors.white,
  useMaterial3: true,
);
