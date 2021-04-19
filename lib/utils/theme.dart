import 'package:flutter/material.dart';

class Palette {
  static Color white = Color(0XFFFFFFFF);

  static Color primary = Color(0XFFFF2C52);
  static Color accent = Color(0XFF29ECE5);

  static Color black = Color(0XFF050505);

  static Map<String, Color> darklight = {
    "dark": Color(0XFF171717),
    "light": Color(0XFFEBEBEB),
  };
}

class MyTextStyles {
  //Bold
  static TextStyle bigTitleBold = TextStyle(
    fontFamily: 'Montserrat',
    color: Palette.black,
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
  );
  static TextStyle titleBold = TextStyle(
    fontFamily: 'Montserrat',
    color: Palette.black,
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
  );
  static TextStyle subTitleBold = TextStyle(
    fontFamily: 'Montserrat',
    color: Palette.black,
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
  );

  //Normal
  static TextStyle bigTitle = TextStyle(
    fontFamily: 'Montserrat',
    color: Palette.black,
    fontSize: 20.0,
  );
  static TextStyle title = TextStyle(
    fontFamily: 'Montserrat',
    color: Palette.black,
    fontSize: 18.0,
  );
  static TextStyle subTitle = TextStyle(
    fontFamily: 'Montserrat',
    color: Palette.black,
    fontSize: 16.0,
  );

  //Thin
  static TextStyle bigTitleThin = TextStyle(
    fontFamily: 'Montserrat',
    color: Palette.black,
    fontSize: 20.0,
    fontWeight: FontWeight.w100,
  );
  static TextStyle titleThin = TextStyle(
    fontFamily: 'Montserrat',
    color: Palette.black,
    fontSize: 18.0,
    fontWeight: FontWeight.w100,
  );
  static TextStyle subTitleThin = TextStyle(
    fontFamily: 'Montserrat',
    color: Palette.black,
    fontSize: 16.0,
    fontWeight: FontWeight.w100,
  );
}
