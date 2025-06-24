import 'package:flutter/material.dart';
import 'settings_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2A815E),
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white, size: 32),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),
                ),
                const SizedBox(width: 8),
                Image.asset('assets/logo.jpg', height: 38),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'HelloFarmer',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Text(
                      'O Futuro do Agricultor',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Builder(
              builder: (context) => GestureDetector(
                onTap: () => Scaffold.of(context).openEndDrawer(),
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20,
                  child: Icon(Icons.person, color: Color(0xFF2A815E), size: 28),
                ),
              ),
            ),
          ],
        ),
        toolbarHeight: 70,
      ),
      drawer: Drawer(
        child: ListView(
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF2A815E)),
              child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 22)),
            ),
            ListTile(title: Text('Página Inicial')),
            ListTile(title: Text('Encomendas')),
            ListTile(title: Text('Produtos')),
            ListTile(title: Text('Clientes')),
            ListTile(title: Text('Análise de Dados')),
            ListTile(title: Text('Canais de Vendas')),
            ListTile(title: Text('Anúncios')),
            ListTile(title: Text('Destaque de Anúncios')),
            ListTile(title: Text('Finanças')),
            ListTile(title: Text('Tutoriais')),
          ],
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: const [
            SizedBox(height: 32),
            CircleAvatar(radius: 40, backgroundColor: Color(0xFF2A815E), child: Icon(Icons.person, color: Colors.white, size: 48)),
            SizedBox(height: 16),
            Text('Nome: Alexandre Miguel', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Email: alexandre@email.com', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Divider(),
            ListTile(leading: Icon(Icons.settings), title: Text('Definições')),
            ListTile(leading: Icon(Icons.logout), title: Text('Sair')),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListView(
          children: [
            const SizedBox(height: 12),
            const Text(
              'Bem Vind@ à HelloFarmer!',
              style: TextStyle(
                color: Color(0xFF1B4B38),
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Divider(height: 32, thickness: 1.2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Recomendados para si...',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B4B38),
                    fontSize: 20,
                  ),
                ),
                Text(
                  'Ver mais',
                  style: TextStyle(
                    color: Color(0xFF2A815E),
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _recommendationCardWithImage(
                    'Preços de Sistema de Irrigação na Região',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _recommendationCardWithImage(
                    'Preços das Embalagens na Região',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Estes são os possíveis Parceiros/Fornecedores que achamos que poderão ser úteis...',
              style: TextStyle(color: Color(0xFF1B4B38), fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Divider(height: 32, thickness: 1.2),
            const SizedBox(height: 8),
            const Text(
              'Alguma Dúvida?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Color(0xFF1B4B38),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Entre em contacto connosco!',
              style: TextStyle(color: Color(0xFF2A815E), fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  static Widget _recommendationCardWithImage(String title) {
    return Card(
      color: const Color(0xFFF2F5F3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        height: 160,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 80,
              width: 110,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.image,
                size: 48,
                color: Color(0xFFB0B0B0),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF1B4B38),
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
