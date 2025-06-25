import 'package:flutter/material.dart';
import 'hellofarmer_app_bar.dart';
import 'profile_drawer.dart';
import 'preferences_drawer.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final List<String> _notifications = [
    'O seu anúncio está destacado por mais 5 dias!',
    'Veja as suas Avaliações!',
    'Este Comercial Enviou-lhe uma mensagem',
    'Quer encontrar alguma parceria?',
    'Nova avaliação recebida!',
    'Promoção especial para produtores!',
    'Atualização de política de privacidade',
  ];

  bool _showAll = false;

  @override
  Widget build(BuildContext context) {
    final notificationsToShow = _showAll ? _notifications : _notifications.take(4).toList();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HelloFarmerAppBar(
        onProfilePressed: () {
          showProfileDrawer(context);
        },
      ),
      drawer: PreferencesDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: notificationsToShow.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(title: Text(notificationsToShow[index])),
                  );
                },
              ),
            ),
            if (!_showAll && _notifications.length > 4)
              TextButton(
                onPressed: () => setState(() => _showAll = true),
                child: const Text('Ver mais'),
              ),
          ],
        ),
      ),
    );
  }
} 