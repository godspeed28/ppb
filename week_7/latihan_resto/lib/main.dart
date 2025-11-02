import 'package:flutter/material.dart';
import 'package:latihan_resto/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Warung Ajib",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(142, 192, 124, 1.0)),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}
