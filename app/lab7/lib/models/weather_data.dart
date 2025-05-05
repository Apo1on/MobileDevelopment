
import 'package:hive/hive.dart';

part 'weather_data.g.dart';

@HiveType(typeId: 1)
class WeatherData {
  @HiveField(0) final String city;
  @HiveField(1) final int cityId; 
  @HiveField(2) final double temperature;
  
  @HiveField(3)  final String description;
  
  @HiveField(4) final DateTime date;
  
  WeatherData({
    required this.city,
    required this.cityId,
    required this.temperature,
    required this.description,
    required this.date,
  });
}