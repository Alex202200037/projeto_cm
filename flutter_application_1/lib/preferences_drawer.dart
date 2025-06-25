import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'settings_page.dart';
import 'contacts_page.dart';
import 'management_page.dart';
import 'main_navigation_controller.dart';

class PreferencesDrawer extends StatelessWidget {
  final Function(int)? onTabSelected;
  
  const PreferencesDrawer({super.key, this.onTabSelected});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFF2A815E)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30,
                  backgroundImage: FirebaseAuth.instance.currentUser?.photoURL != null
                      ? NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!)
                      : null,
                  child: FirebaseAuth.instance.currentUser?.photoURL == null
                      ? const Icon(
                          Icons.person,
                          color: Color(0xFF2A815E),
                          size: 35,
                        )
                      : null,
                ),
                const SizedBox(height: 10),
                Text(
                  FirebaseAuth.instance.currentUser?.displayName ?? 'Utilizador',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  FirebaseAuth.instance.currentUser?.email ?? '',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.home,
            title: 'Página Inicial',
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
              Future.delayed(const Duration(milliseconds: 100), () {
                MainNavigationController().changeTab?.call(0);
              });
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.shopping_cart,
            title: 'Vendas',
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
              Future.delayed(const Duration(milliseconds: 100), () {
                MainNavigationController().changeTab?.call(1);
              });
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.agriculture,
            title: 'Banca/Mercado',
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
              Future.delayed(const Duration(milliseconds: 100), () {
                MainNavigationController().changeTab?.call(2);
              });
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.notifications,
            title: 'Notificações',
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
              Future.delayed(const Duration(milliseconds: 100), () {
                MainNavigationController().changeTab?.call(3);
              });
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.settings,
            title: 'Gestão',
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
              Future.delayed(const Duration(milliseconds: 100), () {
                MainNavigationController().changeTab?.call(4);
                ManagementPageController().changeSection?.call(0);
              });
            },
          ),
          const Divider(),
          _buildDrawerItem(
            context,
            icon: Icons.shopping_bag,
            title: 'Encomendas',
            onTap: () {
              Navigator.pop(context);
              Navigator.popUntil(context, (route) => route.isFirst);
              Future.delayed(const Duration(milliseconds: 100), () {
                MainNavigationController().changeTab?.call(4);
                ManagementPageController().changeSection?.call(1);
              });
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.inventory,
            title: 'Produtos',
            onTap: () {
              Navigator.pop(context);
              Navigator.popUntil(context, (route) => route.isFirst);
              Future.delayed(const Duration(milliseconds: 100), () {
                MainNavigationController().changeTab?.call(4);
                ManagementPageController().changeSection?.call(2);
              });
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.people,
            title: 'Clientes',
            onTap: () {
              Navigator.pop(context);
              Navigator.popUntil(context, (route) => route.isFirst);
              Future.delayed(const Duration(milliseconds: 100), () {
                MainNavigationController().changeTab?.call(4);
                ManagementPageController().changeSection?.call(3);
              });
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.analytics,
            title: 'Análise de Dados',
            onTap: () {
              Navigator.pop(context);
              Navigator.popUntil(context, (route) => route.isFirst);
              Future.delayed(const Duration(milliseconds: 100), () {
                MainNavigationController().changeTab?.call(4);
                ManagementPageController().changeSection?.call(4);
              });
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.store,
            title: 'Canais de Vendas',
            onTap: () {
              Navigator.pop(context);
              Navigator.popUntil(context, (route) => route.isFirst);
              Future.delayed(const Duration(milliseconds: 100), () {
                MainNavigationController().changeTab?.call(4);
                ManagementPageController().changeSection?.call(5);
              });
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.campaign,
            title: 'Anúncios',
            onTap: () {
              Navigator.pop(context);
              Navigator.popUntil(context, (route) => route.isFirst);
              Future.delayed(const Duration(milliseconds: 100), () {
                MainNavigationController().changeTab?.call(4);
                ManagementPageController().changeSection?.call(6);
              });
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.star,
            title: 'Destaque de Anúncios',
            onTap: () {
              Navigator.pop(context);
              Navigator.popUntil(context, (route) => route.isFirst);
              Future.delayed(const Duration(milliseconds: 100), () {
                MainNavigationController().changeTab?.call(4);
                ManagementPageController().changeSection?.call(7);
              });
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.euro,
            title: 'Finanças',
            onTap: () {
              Navigator.pop(context);
              Navigator.popUntil(context, (route) => route.isFirst);
              Future.delayed(const Duration(milliseconds: 100), () {
                MainNavigationController().changeTab?.call(4);
                ManagementPageController().changeSection?.call(8);
              });
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.school,
            title: 'Tutoriais',
            onTap: () {
              Navigator.pop(context);
              Navigator.popUntil(context, (route) => route.isFirst);
              Future.delayed(const Duration(milliseconds: 100), () {
                MainNavigationController().changeTab?.call(4);
                ManagementPageController().changeSection?.call(9);
              });
            },
          ),
          const Divider(),
          _buildDrawerItem(
            context,
            icon: Icons.contact_support,
            title: 'Contactos',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ContactsPage()),
              );
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.settings,
            title: 'Definições',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.logout,
            title: 'Sair',
            onTap: () async {
              Navigator.pop(context);
              await FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF2A815E)),
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF1B4B38),
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
      hoverColor: const Color(0xFF2A815E).withOpacity(0.1),
    );
  }
}
