import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'profile_drawer.dart';
import 'hellofarmer_app_bar.dart';
import 'preferences_drawer.dart';
import 'main_navigation_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ManagementPage extends StatefulWidget {
  final int initialSection;
  const ManagementPage({super.key, this.initialSection = 0});

  @override
  State<ManagementPage> createState() => _ManagementPageState();
}

class _ManagementPageState extends State<ManagementPage> {
  int _selectedSection = 0;
  int? _expandedCard;

  final List<String> _sections = [
    'Página Inicial',
    'Encomendas',
    'Produtos',
    'Clientes',
    'Análise de Dados',
    'Canais de Vendas',
    'Anúncios',
    'Destaque de Anúncios',
    'Finanças',
    'Tutoriais',
  ];

  final Map<String, List<Map<String, dynamic>>> _sectionCards = {
    'Página Inicial': [
      {'label': 'Resumo do Dia', 'value': 'OK', 'type': 'resumo_dia'},
      {'label': 'Alertas Importantes', 'value': 2, 'type': 'alertas'},
    ],
    'Encomendas': [
      {
        'label': 'Encomendas Pendentes',
        'value': 7,
        'type': 'encomendas_pendentes',
      },
      {
        'label': 'Encomendas Entregues',
        'value': 21,
        'type': 'encomendas_entregues',
      },
    ],
    'Produtos': [
      {'label': 'Produtos Ativos', 'value': 12, 'type': 'produtos_ativos'},
      {'label': 'Produtos Esgotados', 'value': 2, 'type': 'produtos_esgotados'},
    ],
    'Clientes': [
      {'label': 'Clientes da Semana', 'value': 15, 'type': 'clientes_semana'},
      {'label': 'Nº Total de Clientes', 'value': 53, 'type': 'clientes_total'},
    ],
    'Análise de Dados': [
      {'label': 'Vendas do Mês', 'value': '1.200€', 'type': 'vendas_mes'},
      {
        'label': 'Produtos Mais Vendidos',
        'value': 'Batatas',
        'type': 'mais_vendidos',
      },
    ],
    'Canais de Vendas': [
      {'label': 'Mercado Local', 'value': 5, 'type': 'mercado_local'},
      {'label': 'Online', 'value': 3, 'type': 'online'},
    ],
    'Anúncios': [
      {'label': 'Anúncios Ativos', 'value': 4, 'type': 'anuncios_ativos'},
      {'label': 'Anúncios Expirados', 'value': 1, 'type': 'anuncios_expirados'},
    ],
    'Destaque de Anúncios': [
      {
        'label': 'Anúncios em Destaque',
        'value': 2,
        'type': 'anuncios_destaque',
      },
      {'label': 'Dias Restantes', 'value': 5, 'type': 'dias_destaque'},
    ],
    'Finanças': [
      {'label': 'Saldo Atual', 'value': '3.500€', 'type': 'saldo_atual'},
      {'label': 'Despesas do Mês', 'value': '800€', 'type': 'despesas_mes'},
    ],
    'Tutoriais': [
      {'label': 'Tutoriais Disponíveis', 'value': 6, 'type': 'tutoriais_disp'},
      {'label': 'Visualizações', 'value': 120, 'type': 'tutoriais_views'},
    ],
  };

  @override
  void initState() {
    super.initState();
    _selectedSection = widget.initialSection;
    ManagementPageController().changeSection = (int section) {
      setState(() {
        _selectedSection = section;
        _expandedCard = null;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    final section = _sections[_selectedSection];
    final cards = _sectionCards[section]!;
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: PreferencesDrawer(),
      body: Column(
        children: [
          HelloFarmerAppBar(
            onProfilePressed: () {
              showProfileDrawer(context);
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 16,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionMenu(
                    sections: _sections,
                    selectedSection: _selectedSection,
                    onSectionTap: (i) {
                      setState(() {
                        _selectedSection = i;
                        _expandedCard = null;
                      });
                    },
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          section,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1B4B38),
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Tudo num só lugar!',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF2A815E),
                          ),
                        ),
                        const SizedBox(height: 24),
                        SummaryCards(
                          cards: cards,
                          expandedCard: _expandedCard,
                          onCardTap: (i) {
                            setState(() {
                              _expandedCard = _expandedCard == i ? null : i;
                            });
                          },
                        ),
                        const SizedBox(height: 32),
                        if (_expandedCard != null)
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 8),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 12,
                                ),
                              ],
                            ),
                            child: _buildDetailsContent(
                              cards[_expandedCard!]['type'],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsContent(String type) {
    switch (type) {
      case 'resumo_dia':
        return const Text('Tudo está a funcionar normalmente.');
      case 'alertas':
        return const Text(
          '2 alertas importantes: Verifique as encomendas pendentes e produtos esgotados.',
        );
      case 'encomendas_pendentes':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Encomendas Pendentes',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...List.generate(
              7,
              (i) => Text(
                'Encomenda #12${30 + i} - Cliente ${['Maria', 'João', 'Ana', 'Carlos', 'Pedro', 'Sofia', 'Rita'][i]}',
              ),
            ),
          ],
        );
      case 'encomendas_entregues':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Encomendas Entregues',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...List.generate(
              5,
              (i) => Text(
                'Encomenda #12${40 + i} - Cliente ${['Sofia', 'Rita', 'Miguel', 'Tiago', 'Helena'][i]}',
              ),
            ),
          ],
        );
      case 'produtos_ativos':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Produtos Ativos',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...[
              'Batatas',
              'Cenouras',
              'Tomates',
              'Cereais',
              'Alfaces',
              'Cebolas',
              'Pepinos',
              'Pimentos',
              'Abóboras',
              'Espinafres',
              'Alho',
              'Couve',
            ].map((p) => Text(p)),
          ],
        );
      case 'produtos_esgotados':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Produtos Esgotados',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...['Batata Doce', 'Couve Roxa'].map((p) => Text(p)),
          ],
        );
      case 'clientes_semana':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Clientes por dia da semana',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 120,
              child: BarChart(
                BarChartData(
                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(toY: 2, color: Color(0xFF2A815E)),
                      ],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(toY: 3, color: Color(0xFF2A815E)),
                      ],
                    ),
                    BarChartGroupData(
                      x: 2,
                      barRods: [
                        BarChartRodData(toY: 1, color: Color(0xFF2A815E)),
                      ],
                    ),
                    BarChartGroupData(
                      x: 3,
                      barRods: [
                        BarChartRodData(toY: 4, color: Color(0xFF2A815E)),
                      ],
                    ),
                    BarChartGroupData(
                      x: 4,
                      barRods: [
                        BarChartRodData(toY: 2, color: Color(0xFF2A815E)),
                      ],
                    ),
                    BarChartGroupData(
                      x: 5,
                      barRods: [
                        BarChartRodData(toY: 2, color: Color(0xFF2A815E)),
                      ],
                    ),
                    BarChartGroupData(
                      x: 6,
                      barRods: [
                        BarChartRodData(toY: 1, color: Color(0xFF2A815E)),
                      ],
                    ),
                  ],
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
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
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: false),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Lista de clientes da semana:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ...[
              'Maria Silva',
              'João Costa',
              'Ana Lopes',
              'Carlos Dias',
              'Pedro Ramos',
            ].map((c) => Text(c)),
          ],
        );
      case 'clientes_total':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Distribuição de clientes por tipo',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 120,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: 30,
                      color: Color(0xFF2A815E),
                      title: 'Ativos',
                    ),
                    PieChartSectionData(
                      value: 15,
                      color: Color(0xFFB0B0B0),
                      title: 'Inativos',
                    ),
                    PieChartSectionData(
                      value: 8,
                      color: Color(0xFF6FCF97),
                      title: 'Novos',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Clientes ativos:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ...['Maria Silva', 'João Costa', 'Ana Lopes'].map((c) => Text(c)),
          ],
        );
      case 'vendas_mes':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Vendas do Mês',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 120,
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
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
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
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: false),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Resumo de vendas:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ...[
              'Batatas: 200€',
              'Tomates: 150€',
              'Cenouras: 100€',
            ].map((v) => Text(v)),
          ],
        );
      case 'mais_vendidos':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Produtos Mais Vendidos',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...['Batatas', 'Tomates', 'Cenouras'].map((p) => Text(p)),
          ],
        );
      case 'mercado_local':
        return const Text('Vendas no Mercado Local: 5 esta semana.');
      case 'online':
        return const Text('Vendas Online: 3 esta semana.');
      case 'anuncios_ativos':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Anúncios Ativos',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...[
              'Batatas - 3 dias restantes',
              'Cenouras - 1 dia restante',
              'Tomates - 5 dias restantes',
              'Cereais - 2 dias restantes',
            ].map((a) => Text(a)),
          ],
        );
      case 'anuncios_expirados':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Anúncios Expirados',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...['Alfaces', 'Cebolas'].map((a) => Text(a)),
          ],
        );
      case 'anuncios_destaque':
        return const Text('2 anúncios em destaque atualmente.');
      case 'dias_destaque':
        return const Text(
          '5 dias restantes de destaque para o anúncio principal.',
        );
      case 'saldo_atual':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Saldo Atual',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text('Saldo disponível para operações e pagamentos.'),
          ],
        );
      case 'despesas_mes':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Despesas do Mês',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...[
              'Água: 200€',
              'Sementes: 150€',
              'Transporte: 100€',
            ].map((d) => Text(d)),
          ],
        );
      case 'tutoriais_disp':
        return const Text('6 tutoriais disponíveis para consulta.');
      case 'tutoriais_views':
        return const Text('120 visualizações totais dos tutoriais.');
      default:
        return const Text('Mais detalhes em breve!');
    }
  }
}

class SectionMenu extends StatelessWidget {
  final List<String> sections;
  final int selectedSection;
  final ValueChanged<int> onSectionTap;
  const SectionMenu({
    required this.sections,
    required this.selectedSection,
    required this.onSectionTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: sections.length,
        itemBuilder: (context, i) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: ListTile(
            title: Text(
              sections[i],
              style: TextStyle(
                color: selectedSection == i
                    ? const Color(0xFF2A815E)
                    : Colors.black,
                fontWeight: selectedSection == i
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
            selected: selectedSection == i,
            selectedTileColor: const Color(0xFFD2E6DD),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            onTap: () => onSectionTap(i),
          ),
        ),
      ),
    );
  }
}

class SummaryCards extends StatelessWidget {
  final List<Map<String, dynamic>> cards;
  final int? expandedCard;
  final ValueChanged<int> onCardTap;
  const SummaryCards({
    required this.cards,
    required this.expandedCard,
    required this.onCardTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(cards.length, (i) {
        final card = cards[i];
        final isExpanded = expandedCard == i;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: GestureDetector(
            onTap: () => onCardTap(i),
            child: Container(
              width: 220,
              height: 90,
              decoration: BoxDecoration(
                color: isExpanded
                    ? const Color(0xFF2A815E)
                    : const Color(0xFFD2E6DD),
                borderRadius: BorderRadius.circular(12),
                boxShadow: isExpanded
                    ? [BoxShadow(color: Colors.black26, blurRadius: 8)]
                    : [],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    card['label'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: isExpanded ? Colors.white : Colors.black,
                      fontWeight: isExpanded
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${card['value']}',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: isExpanded ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class HelloFarmerProfileDrawer extends StatelessWidget {
  const HelloFarmerProfileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          CircleAvatar(
            radius: 40,
            backgroundColor: const Color(0xFF2A815E),
            backgroundImage: user?.photoURL != null
                ? NetworkImage(user!.photoURL!)
                : null,
            child: user?.photoURL == null
                ? const Icon(Icons.person, color: Colors.white, size: 48)
                : null,
          ),
          const SizedBox(height: 16),
          Text(
            user?.displayName ?? 'Nome não disponível',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 8),
          Text(
            user?.email ?? 'Email não disponível',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          const Divider(),
          const ListTile(leading: Icon(Icons.settings), title: Text('Definições')),
          const ListTile(leading: Icon(Icons.logout), title: Text('Sair')),
        ],
      ),
    );
  }
}
