import 'package:flutter/material.dart';

class ProfileDrawer extends StatelessWidget {
  const ProfileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: const [
        SizedBox(height: 32),
        CircleAvatar(
          radius: 40,
          backgroundColor: Color(0xFF2A815E),
          child: Icon(Icons.person, color: Colors.white, size: 48),
        ),
        SizedBox(height: 16),
        Text(
          'Nome: Alexandre Miguel',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8),
        Text(
          'Email: alexandre@email.com',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8),
        Divider(),
        ListTile(leading: Icon(Icons.settings), title: Text('Definições')),
        ListTile(leading: Icon(Icons.logout), title: Text('Sair')),
      ],
    );
  }
}

void showProfileDrawer(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) => const ProfileDrawer(),
  );
}
