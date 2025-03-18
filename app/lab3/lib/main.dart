import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget 
{
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

class IMTCal extends StatefulWidget  
{
  const IMTCal({super.key});

  @override
  State<IMTCal> createState() => _IMTCalState();
}

class _IMTCalState extends State<IMTCal> 
{
  final _formKey = GlobalKey<FormState>();
  final _weightBox = TextEditingController();
  final _heightBox = TextEditingController();
  bool _diavolSign = false;

  @override
  void dispose() {
    _weightBox.dispose();
    _heightBox.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Калькулятор ИМТ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _weightBox,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Вес (кг)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) 
                  {
                    return 'Введите ваш вес';
                  }
                  if (double.parse(value) <= 0)
                  {
                    return 'Вес больше нуля';
                  }
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _heightBox,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Рост (см)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) 
                  {
                    return 'Введите ваш рост';
                  }
                  if (double.parse(value) <= 0)
                  {
                    return 'Рост больше нуля';
                  }
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: <Widget>[
                  Checkbox(
                    value: _diavolSign,
                    onChanged: (value)
                    { 
                      setState(() 
                      {
                        _diavolSign = value!;
                      }); 
                    },
                  ),
                  const Text('Согласие на обработку данных'),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() && _diavolSign) 
                    {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FinalImtScreen(
                            weight: double.parse(_weightBox.text),
                            height: double.parse(_heightBox.text),
                          ),
                        ),
                      );
                    } 
                  else 
                    {
                      if (!_diavolSign) 
                        {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Пожалуйста, передайте свои данные третьим лицам'),
                            ),
                          );
                        }
                    }
                },

                child: const Text('Рассчитать ИМТ'), 
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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

