import 'package:flutter/material.dart';
import 'welcome_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'Criar Conta',
                  style: TextStyle(
                    color: Color(0xFF1B4B38),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                _buildInput('Nome'),
                const SizedBox(height: 16),
                _buildInput('Email'),
                const SizedBox(height: 16),
                _buildInput('Password', obscure: true),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () async {
                    // Simular registo
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('isLoggedIn', true);
                    // Buscar email do campo
                    final emailField = (context as Element).findAncestorWidgetOfExactType<SignUpPage>()?.key;
                    // Para já, guardar um email fictício
                    await prefs.setString('userEmail', 'user@email.com');
                    Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => const MainNavigation()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2A815E),
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text("Registar"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInput(String label, {bool obscure = false}) {
    return TextFormField(
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
