import 'package:flutter/material.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2A815E),
        title: const Text('Contactos', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Telemóvel: 000000000', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            const Text('Email: hellofarmer@gmail.com', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            const Text('Redes sociais:', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            Row(
              children: const [
                Icon(Icons.camera_alt, size: 36), // Instagram (placeholder)
                SizedBox(width: 16),
                Icon(Icons.business, size: 36), // LinkedIn (placeholder)
                SizedBox(width: 16),
                Icon(Icons.g_mobiledata, size: 36), // Google (placeholder)
                SizedBox(width: 16),
                Icon(Icons.clear, size: 36), // X/Twitter (placeholder)
                SizedBox(width: 16),
                Icon(Icons.facebook, size: 36), // Facebook (placeholder)
              ],
            ),
          ],
        ),
      ),
    );
  }
} 