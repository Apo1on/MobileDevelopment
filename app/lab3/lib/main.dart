import 'package:flutter/material.dart';
import 'screens/imt_cal_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Калькулятор ИМТ',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const IMTCal(),
    );
  }
}