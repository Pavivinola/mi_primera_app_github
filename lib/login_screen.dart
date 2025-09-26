// login_screen.dart
import 'package:flutter/material.dart';
import 'package:bibliopavini/login_fields.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BiblioPavini - Login"),
      ),
      body: SafeArea( // 👈 aquí sin const
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16), // este sí puede ser const
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420), // también puede ser const
              child: const LoginFields(), // este SÍ puede ser const porque LoginFields tiene un constructor const
            ),
          ),
        ),
      ),
    );
  }
}
