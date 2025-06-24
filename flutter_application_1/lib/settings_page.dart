import 'package:flutter/material.dart';
import 'welcome_page.dart';
import 'profile_drawer.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2A815E),
        title: Row(
          children: [
            Image.asset(
              'assets/logo.jpg',
              height: 30,
            ), // coloca o teu logo aqui
            const SizedBox(width: 10),
            const Text('HelloFarmer', style: TextStyle(color: Colors.white)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.white),
            onPressed: () => showProfileDrawer(context),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Definições',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B4B38),
                ),
              ),
            ),
            const Divider(thickness: 1, height: 32, color: Color(0xFF2A815E)),
            const SettingsItem(
              title: 'Geral',
              subtitle: 'Veja e atualize os detalhes da sua loja',
            ),
            const SettingsItem(
              title: 'Métodos de Pagamento',
              subtitle: 'Escolha como pretende receber os pagamentos',
            ),
            const SettingsItem(
              title: 'Logística',
              subtitle: 'Gerencie como envia produtos para os clientes',
            ),
            const SettingsItem(
              title: 'Faturação',
              subtitle: 'Gerencie toda a faturação',
            ),
            const SettingsItem(
              title: 'Conta',
              subtitle: 'Gerencie a conta e as permissões',
            ),
            const SettingsItem(
              title: 'Acessibilidade',
              subtitle: 'Adapte a sua experiência ao seu gosto',
            ),
            const SettingsItem(
              title: 'Créditos',
              subtitle: 'Veja quem criou esta bonita aplicação :D',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF2A815E),
        onPressed: () {
          // mais tarde
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  final String title;
  final String subtitle;

  const SettingsItem({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B4B38),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: Color(0xFF2A815E))),
        ],
      ),
    );
  }
}
