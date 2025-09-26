// main.dart
// Punto de entrada de la app BiblioPavini
import 'package:flutter/material.dart';
import 'package:bibliopavini/login_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "BiblioPavini", // Nombre de la app
theme: ThemeData(
  useMaterial3: true,
  colorSchemeSeed: const Color.fromARGB(255, 137, 150, 0), // turquesa
  brightness: Brightness.light, // o .dark para modo oscuro
),
      home: const LoginScreen(),
    );
  }
}
