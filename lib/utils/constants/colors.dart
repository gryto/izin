import 'dart:ui';

import 'package:flutter/material.dart';

class ColorApp {
  // Color Style for Layout
  static const int whiteColor = 0XFFFFFFFF;
  static const int darkColor = 0XFF102C57;
  static const int softDarkColor = 0XFF4F6F52;
  static const int softLightColor = 0XFFE48F45;
  static const int lightColor = 0XFFFEFAF6;
  static const int basicColor = 0xff771d1d;
  static const int secondaryColor = 0xffa53333;
  static const int thirdColor = 0xff771d47;
  static const int buttonColor = 0xFF3D0301;
  

  static const Color dark = Color(darkColor);
  static const Color softDark = Color(softDarkColor);
  static const Color softLight = Color(softLightColor);
  static const Color light = Color(lightColor);
  static const Color basic = Color(basicColor);
  static const Color secondary = Color(secondaryColor);
  static const Color third = Color(thirdColor);
    static const Color button = Color(buttonColor);

  // Color Style for text
  static const Color textColor = Color(0XFFd6a51f);
  static const Color unclearColorText = Color(0XFF999fbc);
  static const Color baseColorText = Color(0XFFE0144C);
  static const Color buttonColorTextActive = Color(0xffffffff);
  static const Color buttonColorTextUnactive = Color(0xff9196fe);
  static const Color appNameColor = Color(0xff070b64);

  static Map<int, Color> color = {
    50: const Color.fromRGBO(4, 131, 184, .1),
    100: const Color.fromRGBO(4, 131, 184, .2),
    200: const Color.fromRGBO(4, 131, 184, .3),
    300: const Color.fromRGBO(4, 131, 184, .4),
    400: const Color.fromRGBO(4, 131, 184, .5),
    500: const Color.fromRGBO(4, 131, 184, .6),
    600: const Color.fromRGBO(4, 131, 184, .7),
    700: const Color.fromRGBO(4, 131, 184, .8),
    800: const Color.fromRGBO(4, 131, 184, .9),
    900: const Color.fromRGBO(4, 131, 184, 1),
  };

  static MaterialColor materialWhite = MaterialColor(whiteColor, color);
  static MaterialColor materialDark = MaterialColor(darkColor, color);
  static MaterialColor materialSoftDark = MaterialColor(softDarkColor, color);
  static MaterialColor materialLight = MaterialColor(lightColor, color);
  static MaterialColor materialSoftLigh = MaterialColor(softLightColor, color);

}
