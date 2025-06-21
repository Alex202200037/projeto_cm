import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2A815E),
        title: Row(
          children: [
            Image.asset(
              'assets/logo.png', // logo da HelloFarmer
              height: 30,
            ),
            const SizedBox(width: 10),
            const Text(
              'HelloFarmer',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        actions: const [
          Icon(Icons.account_circle, color: Colors.white),
          SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              'Bem Vind@ à HelloFarmer!',
              style: TextStyle(
                color: Color(0xFF1B4B38),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Recomendados para si...',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B4B38),
                  ),
                ),
                Text(
                  'Ver mais',
                  style: TextStyle(color: Color(0xFF2A815E)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _recommendationCard('Preços de Sistema de Irrigação na Região')),
                const SizedBox(width: 12),
                Expanded(child: _recommendationCard('Preços das Embalagens na Região')),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Estes são os possíveis Parceiros/Fornecedores que achamos que poderão ser úteis...',
              style: TextStyle(color: Color(0xFF1B4B38)),
            ),
            const Divider(height: 32),
            const Text(
              'Alguma Dúvida?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xFF1B4B38),
              ),
            ),
            const Text(
              'Entre em contacto connosco!',
              style: TextStyle(color: Color(0xFF2A815E)),
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
        currentIndex: 0, 
        selectedItemColor: const Color(0xFF2A815E),
        unselectedItemColor: const Color(0xFF1B4B38),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Vendas'),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Banca'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notificações'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Gestão'),
        ],
      ),
    );
  }

  static Widget _recommendationCard(String title) {
    return Card(
      color: const Color(0x802A815E), 
      child: SizedBox(
        height: 120,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              title,
              style: const TextStyle(
                color: Color(0xFF1B4B38),
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
