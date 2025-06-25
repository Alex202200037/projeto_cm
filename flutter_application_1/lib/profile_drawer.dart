import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './auth_landing_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'settings_page.dart';

class ProfileDrawer extends StatelessWidget {
  const ProfileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            CircleAvatar(
              radius: 40,
              backgroundColor: const Color(0xFF2A815E),
              backgroundImage: user?.photoURL != null ? NetworkImage(user!.photoURL!) : null,
              child: user?.photoURL == null ? const Icon(Icons.person, color: Colors.white, size: 48) : null,
            ),
            const SizedBox(height: 16),
            Text(
              user?.displayName != null ? 'Nome: ${user!.displayName}' : 'Nome não disponível',
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              user?.email != null ? 'Email: ${user!.email}' : 'Email não disponível',
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Definições'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Sair'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
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
