import 'package:flutter/material.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  ConverterScreenState createState() => ConverterScreenState();
}

class ConverterScreenState extends State<ConverterScreen> {
  final TextEditingController celsiusController = TextEditingController();
  final TextEditingController fahrenheitController = TextEditingController();
  final List<String> conversionHistory = [];

  void convertCtoF() {
    if (celsiusController.text.isEmpty) return;
    
    final celsius = double.tryParse(celsiusController.text) ?? 0;
    final fahrenheit = (celsius * 9 / 5) + 32;
    
    fahrenheitController.text = fahrenheit.toStringAsFixed(1);
    
    addToHistory('$celsius°C = $fahrenheit°F');
  }

  void convertFtoC() {
    if (fahrenheitController.text.isEmpty) return;
    
    final fahrenheit = double.tryParse(fahrenheitController.text) ?? 0;
    final celsius = (fahrenheit - 32) * 5 / 9;
    
    celsiusController.text = celsius.toStringAsFixed(1);
    
    addToHistory('$fahrenheit°F = $celsius°C');
  }

  void addToHistory(String conversion) {
    setState(() {
      conversionHistory.insert(0, conversion);
    });
    
    // Сохраняем последние 10 конвертаций
    if (conversionHistory.length > 10) {
      conversionHistory.removeLast();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Конвертер температур'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: celsiusController,
                    decoration: const InputDecoration(
                      labelText: 'Градусы Цельсия (°C)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onSubmitted: (_) => convertCtoF(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: convertCtoF,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: fahrenheitController,
                    decoration: const InputDecoration(
                      labelText: 'Градусы Фаренгейта (°F)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onSubmitted: (_) => convertFtoC(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: convertFtoC,
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                celsiusController.clear();
                fahrenheitController.clear();
              },
              child: const Text('Очистить'),
            ),
            const SizedBox(height: 20),
            const Text(
              'История конвертаций',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: conversionHistory.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(conversionHistory[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}