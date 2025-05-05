import 'package:flutter/material.dart';

class DeveloperScreen extends StatelessWidget {
  const DeveloperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('О разработчике'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Информация о разработчике',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text('ФИО: Афанасьев Евгений Олегович'),
            Text('Группа: ВМК-22'),
            Text('Контакты: evganev@mail.ru'),
            Text('GitHub: https://github.com/Apo1on'),
          ],
        ),
      ),
    );
  }
}