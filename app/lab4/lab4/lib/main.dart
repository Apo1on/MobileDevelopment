import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/final_imt/final_imt_provider.dart';

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

class IMTCal extends StatefulWidget {
  const IMTCal({super.key});

  @override
  State<IMTCal> createState() => _IMTCalState();
}

class _IMTCalState extends State<IMTCal> {
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
                  if (value == null || value.isEmpty) {
                    return 'Введите ваш вес';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Вес должен быть больше нуля';
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
                  if (value == null || value.isEmpty) {
                    return 'Введите ваш рост';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Рост должен быть больше нуля';
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
                    onChanged: (value) {
                      setState(() {
                        _diavolSign = value!;
                      });
                    },
                  ),
                  const Text('Согласие на обработку данных'),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() && _diavolSign) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FinalImtProvider(
                          weight: double.parse(_weightBox.text),
                          height: double.parse(_heightBox.text),
                        ),
                      ),
                    );
                  } else {
                    if (!_diavolSign) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Пожалуйста, дайте согласие на обработку данных'),
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