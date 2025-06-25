import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_service.dart';
import 'splash_screen.dart';
import 'welcome_page.dart';
import 'sales_page.dart';
import 'market_page.dart';
import 'notifications_page.dart';
import 'management_page.dart';
import 'publish_ad_page.dart';
import 'notification_service.dart';
import 'preferences_drawer.dart';
import 'main_navigation_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  print("🔥 Firebase está ON!");
  print("👤 User atual: ${FirebaseAuth.instance.currentUser}");

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
      home: const AuthGate(),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseService().userChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SplashScreen();
        }
        if (snapshot.hasData) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          final initialTab = args != null && args['tab'] != null ? args['tab'] as int : 0;
          final initialSection = args != null && args['section'] != null ? args['section'] as int : 0;
          return MainNavigation(initialIndex: initialTab, initialSection: initialSection);
        } else {
          return SplashScreen();
        }
      },
    );
  }
}

class MainNavigation extends StatefulWidget {
  final int initialIndex;
  final int initialSection;
  const MainNavigation({super.key, this.initialIndex = 0, this.initialSection = 0});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;
  int _initialSection = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _initialSection = widget.initialSection;
    NotificationService.initialize(context);
    MainNavigationController().changeTab = (int index) {
      setState(() {
        _selectedIndex = index;
      });
    };
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateToTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _openPublishAdModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => PublishAdModal(),
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
      page = StreamBuilder<List<Map<String, dynamic>>>(
        stream: FirebaseService().getAnunciosStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return MarketPage(anuncios: snapshot.data!);
        },
      );
    } else if (_selectedIndex == 3) {
      page = const NotificationsPage();
    } else {
      page = ManagementPage(initialSection: _initialSection);
    }
    return Scaffold(
      body: page,
      drawer: PreferencesDrawer(onTabSelected: _onItemTapped),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF2A815E),
        unselectedItemColor: const Color(0xFF1B4B38),
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        elevation: 8,
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
