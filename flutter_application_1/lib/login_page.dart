import 'package:flutter/material.dart';
import 'welcome_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool isObscured = true;

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
                  'Login',
                  style: TextStyle(
                    color: Color(0xFF1B4B38),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildTextField('Email', Icons.email, false),
                      const SizedBox(height: 16),
                      _buildTextField('Password', Icons.lock, true),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setBool('isLoggedIn', true);
                            await prefs.setString('userEmail', email);
                            Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (_) => const MainNavigation()));
                          }
                        },
                        style: _buttonStyle(),
                        child: const Text("Entrar"),
                      ),
                      const SizedBox(height: 12),
                      OutlinedButton(
                        onPressed: () {
                          // Guest login
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const MainNavigation()));
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0x802A815E)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
                        ),
                        child: const Text(
                          'Entrar como Convidado',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF2A815E),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, bool obscure) {
    return TextFormField(
      obscureText: obscure ? isObscured : false,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        suffixIcon: obscure
            ? IconButton(
                icon: Icon(
                    isObscured ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() => isObscured = !isObscured);
                },
              )
            : null,
      ),
      validator: (value) =>
          (value == null || value.isEmpty) ? 'Campo obrigatório' : null,
      onSaved: (value) {
        if (label == 'Email') email = value!;
        if (label == 'Password') password = value!;
      },
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF2A815E),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
  }
}
