import 'package:flutter/material.dart';

class MyColors {
  // Tailwind
  static const Color black = Color(0xFF000000);
  static const Color oxfordBlue = Color(0xFF14213d);
  static const Color orangeWeb = Color(0xFFfca311);
  static const Color platinum = Color(0xFFe5e5e5);
  static const Color white = Color(0xFFFFFFFF);

  // CSV
  static const Color csvBlack = Color(0xFF000000);
  static const Color csvOxfordBlue = Color(0xFF14213d);
  static const Color csvOrangeWeb = Color(0xFFfca311);
  static const Color csvPlatinum = Color(0xFFe5e5e5);
  static const Color csvWhite = Color(0xFFFFFFFF);

  // With #
  static const Color withHashBlack = Color(0xFF000000);
  static const Color withHashOxfordBlue = Color(0xFF14213d);
  static const Color withHashOrangeWeb = Color(0xFFfca311);
  static const Color withHashPlatinum = Color(0xFFe5e5e5);
  static const Color withHashWhite = Color(0xFFFFFFFF);

  // Array
  static const List<Color> arrayColors = [
    Color(0xFF000000),
    Color(0xFF14213d),
    Color(0xFFfca311),
    Color(0xFFe5e5e5),
    Color(0xFFFFFFFF),
  ];

  // Object
  static const Map<String, Color> objectColors = {
    "Black": Color(0xFF000000),
    "Oxford Blue": Color(0xFF14213d),
    "Orange (web)": Color(0xFFfca311),
    "Platinum": Color(0xFFe5e5e5),
    "White": Color(0xFFFFFFFF),
  };

  // Extended Array
  static const List<Map<String, dynamic>> extendedArrayColors = [
    {"name": "Black", "hex": "000000", "rgb": [0, 0, 0]},
    {"name": "Oxford Blue", "hex": "14213d", "rgb": [20, 33, 61]},
    {"name": "Orange (web)", "hex": "fca311", "rgb": [252, 163, 17]},
    {"name": "Platinum", "hex": "e5e5e5", "rgb": [229, 229, 229]},
    {"name": "White", "hex": "ffffff", "rgb": [255, 255, 255]},
  ];

  // XML
  static const List<Map<String, dynamic>> xmlColors = [
    {"name": "Black", "hex": "000000", "r": 0, "g": 0, "b": 0},
    {"name": "Oxford Blue", "hex": "14213d", "r": 20, "g": 33, "b": 61},
    {"name": "Orange (web)", "hex": "fca311", "r": 252, "g": 163, "b": 17},
    {"name": "Platinum", "hex": "e5e5e5", "r": 229, "g": 229, "b": 229},
    {"name": "White", "hex": "ffffff", "r": 255, "g": 255, "b": 255},
  ];
}
