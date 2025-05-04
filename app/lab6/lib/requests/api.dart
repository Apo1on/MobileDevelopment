import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/photo.dart';

class NasaApi {
  static const String _apiKey = 'eQnprvXukgfNomTanZiHT1DqLApcABzFjI350dyZ';
  static const String _baseUrl = 'https://api.nasa.gov/mars-photos/api/v1/rovers';

  static Future<List<Photo>> getPhotos(String roverName, int sol) async {
    final url = Uri.parse('$_baseUrl/$roverName/photos?sol=$sol&api_key=$_apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final photos = data['photos'] as List;
      return photos.map((json) => Photo.fromJson(json)).toList();
    } else {
      throw Exception('Ошибка загрузки Фото');
    }
  }
}