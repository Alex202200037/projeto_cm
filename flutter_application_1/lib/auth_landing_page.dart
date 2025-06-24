import 'package:flutter/material.dart';
import 'login_page.dart';
import 'sign_up_page.dart';

class AuthLandingPage extends StatelessWidget {
  const AuthLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // LOGO
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF2A815E),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: const [
                    Icon(Icons.agriculture, size: 48, color: Colors.white),
                    SizedBox(height: 12),
                    Text(
                      'HelloFarmer',
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'O Futuro da Agricultura',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // BOTÕES
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const SignUpPage()));
                      },
                      style: _buttonStyle(),
                      child: const Text("Sign in"),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginPage()));
                      },
                      style: _buttonStyle(),
                      child: const Text("Log in"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // REDES SOCIAIS (ícones simulados)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  _SocialIcon(icon: Icons.apple),
                  _SocialIcon(icon: Icons.g_mobiledata),
                  _SocialIcon(icon: Icons.facebook),
                  _SocialIcon(icon: Icons.alternate_email),
                  _SocialIcon(icon: Icons.camera_alt),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF2A815E),
      padding: const EdgeInsets.symmetric(vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;

  const _SocialIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: const Color(0xFF2A815E),
      radius: 22,
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }
}
