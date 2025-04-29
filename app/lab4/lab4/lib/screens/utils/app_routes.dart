import 'package:flutter/material.dart';
import 'package:imt_calculator/screens/imt_cal_screen.dart';
import 'package:imt_calculator/screens/list/imt_list_screen.dart';

class AppRoutes {
  static const String imtCal = '/imtCal';
  static const String imtList = '/imtList';

  static Map<String, WidgetBuilder> routes = {
    imtCal: (context) => const IMTCal(),
    imtList: (context) => const ImtListScreen(), // Add the route for the list screen
  };
}