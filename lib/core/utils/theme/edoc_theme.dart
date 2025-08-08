import 'package:flutter/material.dart';

class EdocTheme {
  static ThemeData get lightTheme {
    //Chế độ sáng
    return ThemeData(
        //2
        // primaryColor: const Color(0xFF006076), // Màu chính
        primaryColor: const Color(0xFF005D7F), // Màu chính
        // disabledColor: const Color(0x99006076),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Inter',
        //3
        buttonTheme: ButtonThemeData(
          // 4
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          buttonColor: const Color(0xFF005D7F),
        ));
  }

  static ThemeData get darkTheme {
    //Chế độ tối
    return ThemeData(
        //2
        primaryColor: const Color(0xFF005D7F), // Màu chính
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'Inter',
        //3
        buttonTheme: ButtonThemeData(
          // 4
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          buttonColor: const Color(0xFF005D7F),
        ));
  }
}
