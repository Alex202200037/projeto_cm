import 'package:flutter/material.dart';
import 'user_profile_page.dart';
import 'preferences_drawer.dart';
import 'profile_drawer.dart';
import 'hellofarmer_app_bar.dart';

class SalesPage extends StatefulWidget {
  const SalesPage({super.key});

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  final List<Map<String, String>> _deliveries = [
    {
      'type': 'Entrega na morada',
      'address': 'Rua das Flores, 123',
      'date': 'Hoje - até às 16h00',
    },
    {
      'type': 'Transportadora irá recolher o pedido',
      'address': 'Avenida Central, 456',
      'date': 'Hoje - até às 10h00',
    },
    {
      'type': 'Entrega na morada',
      'address': 'Rua do Mercado, 789',
      'date': 'Amanhã - até às 14h00',
    },
    {
      'type': 'Transportadora irá recolher o pedido',
      'address': 'Praça Nova, 321',
      'date': 'Amanhã - até às 11h00',
    },
  ];

  bool _showAll = false;

  @override
  Widget build(BuildContext context) {
    final deliveriesToShow = _showAll
        ? _deliveries
        : _deliveries.take(2).toList();
    return Scaffold(
      appBar: HelloFarmerAppBar(
        onProfilePressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const UserProfilePage()),
          );
        },
      ),
      drawer: PreferencesDrawer(),
      endDrawer: ProfileDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 12),
            const Text(
              'Próximas Entregas',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B4B38),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: deliveriesToShow.length,
                itemBuilder: (context, index) {
                  final delivery = deliveriesToShow[index];
                  return Card(
                    color: const Color(0xFFF2F5F3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 12,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            delivery['type']!.contains('Transportadora')
                                ? Icons.local_shipping
                                : Icons.home,
                            color: const Color(0xFF2A815E),
                            size: 40,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  delivery['type']!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Color(0xFF1B4B38),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Morada: ${delivery['address']}',
                                  style: const TextStyle(fontSize: 15),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  'Data: ${delivery['date']}',
                                  style: const TextStyle(fontSize: 15),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            if (!_showAll && _deliveries.length > 2)
              Center(
                child: TextButton(
                  onPressed: () => setState(() => _showAll = true),
                  child: const Text(
                    'Ver mais',
                    style: TextStyle(
                      color: Color(0xFF2A815E),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
