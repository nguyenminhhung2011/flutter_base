import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/image_const.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/string_extensions.dart';

class Constant {
  static DateTime timeNow = DateTime.now();
  static const double hPadding = 10.0;
  static List<String> banners = [
    ImageConst.banner1,
    ImageConst.banner2,
    ImageConst.banner3
  ];
  static List<Map<String, dynamic>> icons = [
    {
      'icon': '🛒',
      'color': Colors.blue,
    },
    {
      'icon': '🍉',
      'color': Colors.red,
    },
    {
      'icon': '🏥',
      'color': "#07AEAF".toColor(),
    },
    {
      'icon': '👪',
      'color': Colors.yellow,
    },
  ];

  static List<Map<String, dynamic>> budgetItems = [
    {'color': Colors.blue, 'header': 'Shopping', 'icon': '🛒'},
    {'color': '#07AEAF'.toColor(), 'header': 'Health', 'icon': '🏥'},
    {'color': Colors.yellow, 'header': 'Family', 'icon': '👪'}
  ];
  static List<String> boardNumber = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    'Exit',
    '0',
    '🗑️'
  ];
}
