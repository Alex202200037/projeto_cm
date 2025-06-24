import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ManagementDetailsPage extends StatelessWidget {
  final String type;
  final String label;
  const ManagementDetailsPage({super.key, required this.type, required this.label});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2A815E),
        title: Text(label, style: const TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: _buildDetailsContent(),
      ),
    );
  }

  Widget _buildDetailsContent() {
    switch (type) {
      case 'clientes_semana':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Clientes por dia da semana', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  barGroups: [
                    BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 2, color: Color(0xFF2A815E))]),
                    BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 3, color: Color(0xFF2A815E))]),
                    BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 1, color: Color(0xFF2A815E))]),
                    BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 4, color: Color(0xFF2A815E))]),
                    BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 2, color: Color(0xFF2A815E))]),
                    BarChartGroupData(x: 5, barRods: [BarChartRodData(toY: 2, color: Color(0xFF2A815E))]),
                    BarChartGroupData(x: 6, barRods: [BarChartRodData(toY: 1, color: Color(0xFF2A815E))]),
                  ],
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const days = ['S', 'T', 'Q', 'Q', 'S', 'S', 'D'];
                          return Text(days[value.toInt()]);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Lista de clientes da semana:', style: TextStyle(fontWeight: FontWeight.bold)),
            ...['Maria Silva', 'João Costa', 'Ana Lopes', 'Carlos Dias', 'Pedro Ramos'].map((c) => Text(c)),
          ],
        );
      case 'clientes_total':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Distribuição de clientes por tipo', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(value: 30, color: Color(0xFF2A815E), title: 'Ativos'),
                    PieChartSectionData(value: 15, color: Color(0xFFB0B0B0), title: 'Inativos'),
                    PieChartSectionData(value: 8, color: Color(0xFF6FCF97), title: 'Novos'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Clientes ativos:', style: TextStyle(fontWeight: FontWeight.bold)),
            ...['Maria Silva', 'João Costa', 'Ana Lopes'].map((c) => Text(c)),
          ],
        );
      case 'encomendas_pendentes':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Encomendas Pendentes', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            ...List.generate(7, (i) => Text('Encomenda #12${30+i} - Cliente ${['Maria', 'João', 'Ana', 'Carlos', 'Pedro', 'Sofia', 'Rita'][i]}')),
          ],
        );
      case 'produtos_ativos':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Produtos Ativos', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            ...['Batatas', 'Cenouras', 'Tomates', 'Cereais', 'Alfaces', 'Cebolas', 'Pepinos', 'Pimentos', 'Abóboras', 'Espinafres', 'Alho', 'Couve'].map((p) => Text(p)),
          ],
        );
      case 'vendas_mes':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Vendas do Mês', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 200),
                        FlSpot(1, 300),
                        FlSpot(2, 250),
                        FlSpot(3, 400),
                        FlSpot(4, 350),
                        FlSpot(5, 500),
                        FlSpot(6, 600),
                      ],
                      isCurved: true,
                      color: Color(0xFF2A815E),
                      barWidth: 4,
                    ),
                  ],
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const days = ['S', 'T', 'Q', 'Q', 'S', 'S', 'D'];
                          return Text(days[value.toInt()]);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Resumo de vendas:', style: TextStyle(fontWeight: FontWeight.bold)),
            ...['Batatas: 200€', 'Tomates: 150€', 'Cenouras: 100€'].map((v) => Text(v)),
          ],
        );
      case 'anuncios_ativos':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Anúncios Ativos', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            ...['Batatas - 3 dias restantes', 'Cenouras - 1 dia restante', 'Tomates - 5 dias restantes', 'Cereais - 2 dias restantes'].map((a) => Text(a)),
          ],
        );
      default:
        return const Text('Mais detalhes em breve!');
    }
  }
}