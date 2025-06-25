import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'welcome_page.dart';
import 'sales_page.dart';
import 'market_page.dart';
import 'notifications_page.dart';
import 'management_page.dart';
import 'publish_ad_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HelloFarmer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF2A815E)),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    WelcomePage(), // placeholder, will be replaced in build
    const SalesPage(),
    // MarketPage é criado dinamicamente no build
    const NotificationsPage(),
    const ManagementPage(),
  ];

  List<Map<String, String>> _anuncios = [
    {'titulo': 'Cereais', 'preco': '1.50€/kg', 'categoria': 'Cereais', 'detalhes': 'Aveia, Trigo, Cevada'},
    {'titulo': 'Batatas', 'preco': '0.80€/kg', 'categoria': 'Tubérculos', 'detalhes': 'Batata branca, Batata doce'},
    {'titulo': 'Tomates', 'preco': '2.00€/kg', 'categoria': 'Hortícolas', 'detalhes': 'Tomate cherry, Tomate coração de boi'},
    {'titulo': 'Cenouras', 'preco': '1.20€/kg', 'categoria': 'Hortícolas', 'detalhes': 'Cenoura laranja, Cenoura roxa'},
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addAnuncio(Map<String, String> anuncio) {
    setState(() {
      _anuncios.insert(0, anuncio);
      _selectedIndex = 2; // Mudar para tab Banca/Anúncios
    });
  }

  void _openPublishAdModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => PublishAdModal(onPublish: _addAnuncio),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget page;
    if (_selectedIndex == 0) {
      page = WelcomePage(
        currentIndex: _selectedIndex,
        onTabSelected: _onItemTapped,
      );
    } else if (_selectedIndex == 1) {
      page = const SalesPage();
    } else if (_selectedIndex == 2) {
      page = MarketPage(anuncios: _anuncios);
    } else if (_selectedIndex == 3) {
      page = const NotificationsPage();
    } else {
      page = const ManagementPage();
    }
    return Scaffold(
      body: page,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF2A815E),
        unselectedItemColor: const Color(0xFF1B4B38),
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Vendas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.agriculture),
            label: 'Banca',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            label: 'Notificações',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Gestão'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF2A815E),
        onPressed: _openPublishAdModal,
        child: const Icon(Icons.add, size: 36),
      ),
    );
  }
}
