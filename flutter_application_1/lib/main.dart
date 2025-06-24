import 'package:flutter/material.dart';
import 'welcome_page.dart';
import 'sales_page.dart';
import 'market_page.dart';
import 'notifications_page.dart';
import 'management_page.dart';

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
      home: const MainNavigation(),
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

  final List<Widget> _pages = const [
    WelcomePage(),
    SalesPage(),
    MarketPage(),
    NotificationsPage(),
    ManagementPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
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
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: 'Vendas'),
          BottomNavigationBarItem(icon: Icon(Icons.agriculture), label: 'Banca'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_none), label: 'Notificações'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Gestão'),
        ],
      ),
    );
  }
}
