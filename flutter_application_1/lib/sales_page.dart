import 'package:flutter/material.dart';

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
    final deliveriesToShow = _showAll ? _deliveries : _deliveries.take(2).toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2A815E),
        title: const Text('Próximas Entregas', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Próximas Entregas',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1B4B38)),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: deliveriesToShow.length,
                itemBuilder: (context, index) {
                  final delivery = deliveriesToShow[index];
                  return Card(
                    color: const Color(0xFFD2E6DD),
                    margin: const EdgeInsets.only(bottom: 16),
                    child: ListTile(
                      leading: Icon(
                        delivery['type']!.contains('Transportadora') ? Icons.local_shipping : Icons.home,
                        color: const Color(0xFF2A815E),
                        size: 32,
                      ),
                      title: Text(delivery['type']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Morada: ${delivery['address']}'),
                          Text('Data: ${delivery['date']}'),
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
                  child: const Text('Ver mais'),
                ),
              ),
          ],
        ),
      ),
    );
  }
} 