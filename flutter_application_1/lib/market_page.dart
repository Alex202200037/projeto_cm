import 'package:flutter/material.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({super.key});

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Dados fictícios
  final Map<String, dynamic> _banca = {
    'nome': 'Quinta da Alegria',
    'descricao': 'Bem-vindo à Quinta da Alegria, cultivamos com paixão e respeito pela natureza. Produção Sustentável e local. Da nossa terra para a sua mesa, sempre fresco de Qualidade.',
    'localizacao': 'Azeitão',
    'morada': '-5.9531, 39.9206',
    'mercados': [
      'Mercado Mensal de Azeitão',
      'Mercado Agrobio de Almada',
      'Mercado de Setúbal',
    ],
  };

  final List<Map<String, String>> _anuncios = [
    {'titulo': 'Cereais', 'preco': '1.50€/kg', 'categoria': 'Cereais', 'detalhes': 'Aveia, Trigo, Cevada'},
    {'titulo': 'Batatas', 'preco': '0.80€/kg', 'categoria': 'Tubérculos', 'detalhes': 'Batata branca, Batata doce'},
    {'titulo': 'Tomates', 'preco': '2.00€/kg', 'categoria': 'Hortícolas', 'detalhes': 'Tomate cherry, Tomate coração de boi'},
    {'titulo': 'Cenouras', 'preco': '1.20€/kg', 'categoria': 'Hortícolas', 'detalhes': 'Cenoura laranja, Cenoura roxa'},
  ];

  final List<Map<String, String>> _avaliacoes = [
    {'nome': 'Maria Silva', 'comentario': 'Tudo perfeito e a qualidade é notável! Muito Satisfeita!', 'data': 'há 1 semana', 'rating': '5'},
    {'nome': 'João Costa', 'comentario': 'Melhorei bastante a qualidade dos pratos do meu restaurante! Daqui em diante só compro aqui', 'data': 'há 2 semanas', 'rating': '5'},
    {'nome': 'Ana Lopes', 'comentario': 'Produtos sempre frescos e entrega rápida.', 'data': 'há 3 semanas', 'rating': '4'},
    {'nome': 'Carlos Dias', 'comentario': 'Ótimo atendimento e variedade.', 'data': 'há 1 mês', 'rating': '5'},
  ];

  bool _showAllAds = false;
  bool _showAllReviews = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2A815E),
        title: const Text('A Minha Banca', style: TextStyle(color: Colors.white)),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Banca'),
            Tab(text: 'Anúncios'),
            Tab(text: 'Avaliações'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBancaTab(),
          _buildAdsTab(),
          _buildReviewsTab(),
        ],
      ),
    );
  }

  Widget _buildBancaTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          Text(_banca['nome'], style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(_banca['descricao'], style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 16),
          const Text('Detalhes', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Localização: ${_banca['localizacao']}'),
          Text('Morada: ${_banca['morada']}'),
          const SizedBox(height: 16),
          const Text('Mercados Habituais', style: TextStyle(fontWeight: FontWeight.bold)),
          ...(_banca['mercados'] as List<String>).map((m) => Text(m)).toList(),
        ],
      ),
    );
  }

  Widget _buildAdsTab() {
    final adsToShow = _showAllAds ? _anuncios : _anuncios.take(2).toList();
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text('Anúncios Publicados', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: adsToShow.length,
              itemBuilder: (context, index) {
                final ad = adsToShow[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: const Icon(Icons.image, size: 40, color: Color(0xFF2A815E)),
                    title: Text(ad['titulo']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Preço: ${ad['preco']}'),
                        Text('Categoria: ${ad['categoria']}'),
                        Text('Detalhes: ${ad['detalhes']}'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (!_showAllAds && _anuncios.length > 2)
            TextButton(
              onPressed: () => setState(() => _showAllAds = true),
              child: const Text('Ver mais'),
            ),
        ],
      ),
    );
  }

  Widget _buildReviewsTab() {
    final reviewsToShow = _showAllReviews ? _avaliacoes : _avaliacoes.take(2).toList();
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text('Avaliações', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: reviewsToShow.length,
              itemBuilder: (context, index) {
                final review = reviewsToShow[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(child: Text(review['nome']![0])),
                    title: Row(
                      children: [
                        Text(review['nome']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(width: 8),
                        Row(
                          children: List.generate(
                            int.parse(review['rating']!),
                            (i) => const Icon(Icons.star, color: Colors.amber, size: 18),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(review['comentario']!),
                        Text(review['data']!, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (!_showAllReviews && _avaliacoes.length > 2)
            TextButton(
              onPressed: () => setState(() => _showAllReviews = true),
              child: const Text('Ver mais'),
            ),
        ],
      ),
    );
  }
} 