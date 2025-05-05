import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/weather_data.dart';
import 'package:lab7/screens/main_screen.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Hive.initFlutter();
  
  Hive.registerAdapter(WeatherDataAdapter());
  
  await Hive.openBox<WeatherData>('weather_history');
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Погода и конвертер',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
    );
  }
}