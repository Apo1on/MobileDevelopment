import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lab7/models/weather_data.dart';
import 'developer_screen.dart';
import 'converter_screen.dart';
import 'package:url_launcher/url_launcher.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  final TextEditingController cityController = TextEditingController();
  WeatherData? currentWeather;
  final Box<WeatherData> weatherBox = Hive.box<WeatherData>('weather_history');
  Future<void> fetchWeather(String city) async {
    const apiKey = '04999e31813d786aef16feca6acaddce'; 
    try {
      final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?'
        'q=${Uri.encodeComponent(city)}&'
        'appid=$apiKey&'
        'units=metric&'
        'lang=ru'
      );

      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        final weather = WeatherData(
          city: data['name'],
          temperature: data['main']['temp'],
          cityId: data['id'],
          description: data['weather'][0]['description'],
          date: DateTime.now(),
        );
        
        setState(() {
          currentWeather = weather;
        });

        weatherBox.add(weather);
        
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Погода'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DeveloperScreen()),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.swap_horiz),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ConverterScreen()),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: cityController,
                    decoration: const InputDecoration(
                      labelText: 'Введите город',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => fetchWeather(cityController.text),
                ),
              ],
            ),
          ),
          if (currentWeather != null) buildWeatherCard(currentWeather!),
          const SizedBox(height: 20),
          const Text('История запросов', style: TextStyle(fontSize: 18)),
          Expanded(
            child: buildHistoryList(),
          ),
        ],
      ),
    );
  }

  Widget buildWeatherCard(WeatherData weather) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              weather.city,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              '${weather.temperature.toStringAsFixed(1)}°C',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              weather.description,
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Запрошено: ${DateFormat('dd.MM.yyyy HH:mm').format(weather.date)}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            ElevatedButton(
                  onPressed: openWeatherWebsite,
                  child: const Text('Открыть прогноз на сайте'),
                ),
          ],
        ),
      ),
    );
  }
  void openWeatherWebsite() async {
  if (currentWeather == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Сначала получите данные о погоде')),
    );
    return;
  }

  final url = Uri.parse(
    'https://openweathermap.org/city/${currentWeather!.cityId}'
  );

  if (await canLaunchUrl(url)) {
    await launchUrl(
      url,
      mode: LaunchMode.externalApplication,  // Открывает в браузере
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Не удалось открыть сайт')),
    );
  }
}
  Widget buildHistoryList() {
  return ValueListenableBuilder(
    valueListenable: weatherBox.listenable(), // Используем listenable() от Box
    builder: (context, box, _) {
      final history = box.values.toList().reversed.toList();
      
      return ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          final item = history[index];
          return ListTile(
            title: Text(item.city),
            subtitle: Text('${item.temperature.toStringAsFixed(1)}°C - ${item.description}'),
            trailing: Text(DateFormat('HH:mm').format(item.date)),
            onTap: () {
              setState(() {
                currentWeather = item;
                cityController.text = item.city;
              });
              fetchWeather(item.city);
            },
          );
        },
      );
    },
  );
}
}