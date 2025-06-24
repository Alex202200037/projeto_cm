import 'package:flutter/material.dart';

class PreferencesDrawer extends StatelessWidget {
  const PreferencesDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: const [
          DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF2A815E)),
            child: Text(
              'Definições',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
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
    );
  }
}
