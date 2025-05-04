import 'package:flutter/material.dart';
import '../models/photo.dart';
class DetailScreen extends StatelessWidget {
  final Photo photo;

  const DetailScreen({Key? key, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Фото ${photo.id}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(photo.imgSrc),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Марсоход: ${photo.rover.name}', style: Theme.of(context).textTheme.headlineLarge),
                  Text('Статус: ${photo.rover.status}'),
                  Text('Дата запуска: ${photo.rover.launchDate}'),
                  Text('Дата приМарселения: ${photo.rover.landingDate}'),
                  SizedBox(height: 16),
                  Text('Камера: ${photo.camera.fullName}', style: Theme.of(context).textTheme.headlineLarge),
                  Text('Дата по земле: ${photo.earthDate}'),
                  Text('Сол: ${photo.sol}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}