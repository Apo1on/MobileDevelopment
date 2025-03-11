// Афанасьев Евгений ВМК-22


import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ЛР 2',
      
      home: const MyHomePage(title: 'Лабораторная работа 2 Афанасьев Евгений ВМК-22'),
    );
  }
}



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}




class _MyHomePageState extends State<MyHomePage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Wrap(
        spacing: 10,
        children: <Widget>[
          Container(
            color: Colors.blue,
            width: 100,
            height: 75,
            margin: EdgeInsets.only(left: 200)
          ),
          Container(
            color: Colors.red,
            width: 75,
            height: 100,
            margin: EdgeInsets.only(right: 20)
          ),
          Container(
            color: Colors.green,
            width: 50,
            height: 50,
            margin: EdgeInsets.only(right: 20, top: 40)
          ),
          Container(
            color: Colors.grey,
            width: 50,
            height: 50,
            margin: EdgeInsets.only(bottom: 40, left: 30)
            ),
          Container(
            color: Colors.purple,
            width: 100,
            height: 50,
            margin: EdgeInsets.only(top: 40, bottom: 30)
            )
        ],
      ),
      
    );
  }
}
