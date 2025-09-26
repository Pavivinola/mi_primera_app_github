// Pantalla de bienvenida que muestra el correo del usuario
import 'package:flutter/material.dart';

class TaskScreen extends StatelessWidget {
  final String email; // Recibe correo desde login

  const TaskScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("BiblioPavini")),
      body: Center(
        child: Text(
          "Bienvenido $email 👋", // Mensaje piola de bienvenida
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
