import 'dart:math';
import 'package:flutter/material.dart';


class FinalImtScreen extends StatelessWidget 
{
  final double weight;
  final double height;

  const FinalImtScreen({super.key, required this.weight, required this.height});

  double calculate() {
    double heightInMeters = height / 100;
    return weight / (pow(heightInMeters, 2));
  }

  String explainIMT(double imt) {
    if (imt < 18.5) 
      {
        return 'Недостаточный вес';
      } 
    else if (imt < 25) 
      {
        return 'Нормальный вес';
      } 
    else if (imt < 30) 
      {
        return 'Избыточный вес';
      } 
    else {
      return 'Ожирение';
    }
  }

  @override
  Widget build(BuildContext context) {
    final imt = calculate();
    final results = explainIMT(imt);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Результаты'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Ваш ИМТ: ${imt.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            Text(
              'Интерпретация: $results',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); 
              },
              child: const Text('Вернуться'),
            ),
          ],
        ),
      ),
    );
  }
}

