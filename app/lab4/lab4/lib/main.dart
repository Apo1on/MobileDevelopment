import 'package:flutter/material.dart';
import 'package:imt_calculator/screens/imt_cal_screen.dart';
import 'package:imt_calculator/screens/utils/app_routes.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Калькулятор ИМТ',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const IMTCal(),
      routes: AppRoutes.routes, // Add the routes
    );
  }
}