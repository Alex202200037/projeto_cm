import 'package:flutter/material.dart';
import 'welcome_page.dart';

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
              'assets/logo.png',
              height: 30,
            ), // coloca o teu logo aqui
            const SizedBox(width: 10),
            const Text('HelloFarmer', style: TextStyle(color: Colors.white)),
          ],
        ),
        actions: const [
          Icon(Icons.account_circle, color: Colors.white),
          SizedBox(width: 16),
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 4,
        selectedItemColor: const Color(0xFF2A815E),
        unselectedItemColor: const Color(0xFF1B4B38),
        onTap: (index) {
          if (index == 0) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const WelcomePage()),
            );
          } else if (index == 4) {
            // Already on SettingsPage, do nothing
          }
          // Add navigation for other tabs if needed
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Vendas',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Banca'),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notificações',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Gestão'),
        ],
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
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: Color(0xFF2A815E))),
        ],
      ),
    );
  }
}
