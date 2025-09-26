// login_fields.dart
// Contiene los campos de correo y contraseña con validaciones
import 'package:flutter/material.dart';
import 'package:bibliopavini/task_screen.dart';

class LoginFields extends StatefulWidget {
  const LoginFields({super.key});

  @override
  State<LoginFields> createState() => _LoginFieldsState();
}

class _LoginFieldsState extends State<LoginFields> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscure = true; // Controla visibilidad contraseña
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    final ok = _formKey.currentState?.validate() ?? false;
    if (!ok) return;

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      await Future.delayed(const Duration(milliseconds: 2000)); // Simula espera
      if (!mounted) return;

      // Navega a la pantalla de bienvenida
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => TaskScreen(email: _emailCtrl.text)),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = "Credenciales inválidas o error de red");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No se ha podido iniciar sesión")),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Logo de la app desde assets
            Center(
              child: Image.asset(
                "assets/logo.png",
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Bienvenido a BiblioPavini",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            // Campo Email
            TextFormField(
              enabled: !_loading,
              controller: _emailCtrl,
              decoration: const InputDecoration(
                labelText: "Email",
                hintText: "tucorreo@correo.cl",
                prefixIcon: Icon(Icons.email_rounded),
                border: OutlineInputBorder(),
              ),
              validator: (v) {
                final value = v?.trim() ?? '';
                if (value.isEmpty) return "Ingresa tu email";
                final emailOk = RegExp(r'^\S+@\S+\.\S+$').hasMatch(value);
                return emailOk ? null : "Email inválido";
              },
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),

            // Campo Contraseña
            TextFormField(
              enabled: !_loading,
              controller: _passCtrl,
              obscureText: _obscure,
              decoration: InputDecoration(
                labelText: "Contraseña",
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.lock_outlined),
                suffixIcon: IconButton(
                  onPressed: () => setState(() => _obscure = !_obscure),
                  icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
                ),
              ),
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return "Ingrese su contraseña";
                }
                if (val.length < 6) {
                  return "La contraseña debe contener mínimo 6 caracteres";
                }
                return null;
              },
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: 16),

            if (_error != null)
              Text(
                _error!,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 16),

            // Botón Ingresar
            SizedBox(
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 202, 236, 211),
                  foregroundColor: Colors.black
                ),
                onPressed: _loading ? null : _submit,
                child: _loading
                    ? const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : const Text("Ingresar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
