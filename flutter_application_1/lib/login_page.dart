import 'package:flutter/material.dart';
import 'main.dart';
import 'firebase_service.dart';

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
  bool _isLoading = false;
  String? _error;

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
                const SizedBox(height: 24),
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
                      if (_error != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Text(_error!, style: const TextStyle(color: Colors.red)),
                        ),
                      ElevatedButton(
                        onPressed: _isLoading ? null : _onLogin,
                        style: _buttonStyle(),
                        child: _isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text("Entrar"),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton.icon(
                        icon: Image.asset('assets/logo2.jpg', height: 24),
                        label: const Text('Entrar com Google'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 2,
                        ),
                        onPressed: () async {
                          final userCredential = await FirebaseService().signInWithGoogle();
                          if (userCredential != null) {
                            if (context.mounted) {
                              Navigator.of(context).pushReplacementNamed('/');
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Falha ao entrar com Google.')),
                            );
                          }
                        },
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

  Future<void> _onLogin() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      await FirebaseService().loginWithEmail(email.trim(), password.trim());
      if (!mounted) return;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainNavigation()));
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _onGoogleLogin() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      await FirebaseService().signInWithGoogle();
      if (!mounted) return;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainNavigation()));
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
