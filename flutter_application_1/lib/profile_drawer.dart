import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './auth_landing_page.dart';

class ProfileDrawer extends StatelessWidget {
  const ProfileDrawer({super.key});

  Future<String> _getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userEmail') ?? 'alexandre@email.com';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<String>(
        future: _getUserEmail(),
        builder: (context, snapshot) {
          final email = snapshot.data ?? 'alexandre@email.com';
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8),
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Color(0xFF2A815E),
                  child: Icon(Icons.person, color: Colors.white, size: 48),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Nome: Alexandre Miguel',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Email: $email',
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Definições'),
                  onTap: () => Navigator.pop(context),
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Sair'),
                  onTap: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.clear();
                    Navigator.pop(context);
                    Future.delayed(Duration.zero, () {
                      Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const AuthLandingPage() as Widget),
                        (route) => false,
                      );
                    });
                  },
                ),
                const SizedBox(height: 8),
              ],
            ),
          );
        },
      ),
    );
  }
}

void showProfileDrawer(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) => const ProfileDrawer(),
  );
}
