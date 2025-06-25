import 'package:flutter/material.dart';
import 'hellofarmer_app_bar.dart';
import 'profile_drawer.dart';
import 'preferences_drawer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarketPage extends StatefulWidget {
  final List<Map<String, dynamic>> anuncios;
  const MarketPage({Key? key, required this.anuncios}) : super(key: key);

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Dados fictícios
  Map<String, dynamic> _banca = {
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

  final List<Map<String, String>> _avaliacoes = [
    {'nome': 'Maria Silva', 'comentario': 'Tudo perfeito e a qualidade é notável! Muito Satisfeita!', 'data': 'há 1 semana', 'rating': '5'},
    {'nome': 'João Costa', 'comentario': 'Melhorei bastante a qualidade dos pratos do meu restaurante! Daqui em diante só compro aqui', 'data': 'há 2 semanas', 'rating': '5'},
    {'nome': 'Ana Lopes', 'comentario': 'Produtos sempre frescos e entrega rápida.', 'data': 'há 3 semanas', 'rating': '4'},
    {'nome': 'Carlos Dias', 'comentario': 'Ótimo atendimento e variedade.', 'data': 'há 1 mês', 'rating': '5'},
  ];

  bool _showAllAds = false;
  bool _showAllReviews = false;

  Marker? _selectedMarker;
  Map<String, dynamic>? _selectedAnuncio;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HelloFarmerAppBar(
        onProfilePressed: () {
          showProfileDrawer(context);
        },
      ),
      drawer: PreferencesDrawer(),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Banca'),
              Tab(text: 'Anúncios'),
              Tab(text: 'Avaliações'),
              Tab(text: 'Mapa'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView(
                  padding: const EdgeInsets.all(24),
                  children: [
                    const SizedBox(height: 16),
                    Text('A Minha Banca', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF1B4B38)), textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    Divider(thickness: 2, color: Color(0xFF2A815E)),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_banca['nome'], style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1B4B38))),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD2E6DD),
                            foregroundColor: const Color(0xFF1B4B38),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            elevation: 0,
                          ),
                          onPressed: () {
                            _showEditBancaModal(context);
                          },
                          icon: const Icon(Icons.edit, size: 18),
                          label: const Text('Editar Banca'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 160,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Icon(Icons.image, size: 80, color: Color(0xFFB0B0B0)),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text('Descrição', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF1B4B38))),
                    const SizedBox(height: 8),
                    Text(_banca['descricao'], style: const TextStyle(fontSize: 16, color: Color(0xFF1B4B38))),
                    const SizedBox(height: 24),
                    const Text('Detalhes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF1B4B38))),
                    const SizedBox(height: 8),
                    Text('Localização: ${_banca['localizacao']}   Morada: ${_banca['morada']}', style: const TextStyle(fontSize: 16, color: Color(0xFF1B4B38))),
                    const SizedBox(height: 24),
                    const Text('Mercados Habituais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF1B4B38))),
                    const SizedBox(height: 8),
                    ...(_banca['mercados'] as List<String>).map((m) => Text(m, style: const TextStyle(fontSize: 16, color: Color(0xFF1B4B38)))).toList(),
                    const SizedBox(height: 32),
                    Divider(thickness: 2, color: Color(0xFF2A815E)),
                    const SizedBox(height: 24),
                    const Text('Alguma Dúvida?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Color(0xFF1B4B38)), textAlign: TextAlign.center),
                    const SizedBox(height: 8),
                    const Text('Entre em contacto connosco!', style: TextStyle(fontSize: 18, color: Color(0xFF2A815E)), textAlign: TextAlign.center),
                    const SizedBox(height: 60),
                  ],
                ),
                _buildAdsTab(),
                _buildReviewsTab(),
                _buildMapTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdsTab() {
    final adsToShow = _showAllAds ? widget.anuncios : widget.anuncios.take(2).toList();
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
          if (!_showAllAds && widget.anuncios.length > 2)
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

  Widget _buildMapTab() {
    return FutureBuilder<Position?>(
      future: _getUserLocation(),
      builder: (context, userSnapshot) {
        return FutureBuilder<Set<Marker>>(
          future: _getAnuncioMarkers(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            LatLng initialTarget = const LatLng(38.7071, -9.1355); // Lisboa default
            if (userSnapshot.hasData && userSnapshot.data != null) {
              initialTarget = LatLng(userSnapshot.data!.latitude, userSnapshot.data!.longitude);
            }
            return GoogleMap(
              mapType: MapType.satellite,
              initialCameraPosition: CameraPosition(
                target: initialTarget,
                zoom: 12,
              ),
              markers: snapshot.data!,
              myLocationEnabled: userSnapshot.hasData,
              myLocationButtonEnabled: true,
              onTap: (_) {
                setState(() {
                  _selectedMarker = null;
                  _selectedAnuncio = null;
                });
              },
            );
          },
        );
      },
    );
  }

  Future<Position?> _getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return null;
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<Set<Marker>> _getAnuncioMarkers() async {
    Set<Marker> markers = {};
    BitmapDescriptor customIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
    for (var anuncio in widget.anuncios) {
      if (anuncio['localizacao'] != null && anuncio['localizacao']!.isNotEmpty) {
        try {
          List<Location> locations = await locationFromAddress(anuncio['localizacao']!).timeout(const Duration(seconds: 7));
          if (locations.isNotEmpty) {
            final loc = locations.first;
            markers.add(
              Marker(
                markerId: MarkerId(anuncio['titulo'] ?? ''),
                position: LatLng(loc.latitude, loc.longitude),
                icon: customIcon,
                infoWindow: const InfoWindow(title: '', snippet: ''),
                onTap: () {
                  _showAnuncioModal(anuncio);
                },
              ),
            );
          }
        } on TimeoutException catch (_) {
          // Timeout: não adicionar marker, opcionalmente logar
        } catch (e) {
          // Ignore geocoding errors
        }
      }
    }
    return markers;
  }

  void _showEditBancaModal(BuildContext context) {
    final nomeController = TextEditingController(text: _banca['nome']);
    final descricaoController = TextEditingController(text: _banca['descricao']);
    final localizacaoController = TextEditingController(text: _banca['localizacao']);
    final moradaController = TextEditingController(text: _banca['morada']);
    final mercadosController = TextEditingController(text: (_banca['mercados'] as List<String>).join(', '));

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Editar Banca', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                TextField(
                  controller: nomeController,
                  decoration: const InputDecoration(labelText: 'Nome'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: descricaoController,
                  decoration: const InputDecoration(labelText: 'Descrição'),
                  maxLines: 2,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: localizacaoController,
                  decoration: const InputDecoration(labelText: 'Localização'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: moradaController,
                  decoration: const InputDecoration(labelText: 'Morada'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: mercadosController,
                  decoration: const InputDecoration(labelText: 'Mercados (separados por vírgula)'),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade300),
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancelar', style: TextStyle(color: Colors.black)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2A815E)),
                        onPressed: () {
                          setState(() {
                            _banca = {
                              'nome': nomeController.text,
                              'descricao': descricaoController.text,
                              'localizacao': localizacaoController.text,
                              'morada': moradaController.text,
                              'mercados': mercadosController.text.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList(),
                            };
                          });
                          Navigator.pop(context);
                        },
                        child: const Text('Guardar'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAnuncioModal(Map<String, dynamic> anuncio) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: const Color(0xFF2A815E),
                      radius: 32,
                      child: const Icon(Icons.agriculture, color: Colors.white, size: 36),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(anuncio['titulo'] ?? '', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1B4B38))),
                          const SizedBox(height: 4),
                          Text(anuncio['categoria'] ?? '', style: const TextStyle(fontSize: 16, color: Color(0xFF2A815E))),
                        ],
                      ),
                    ),
                    if ((anuncio['preco'] ?? '').isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD2E6DD),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(anuncio['preco'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2A815E), fontSize: 18)),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                if ((anuncio['descricao'] ?? '').isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Descrição', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 4),
                      Text(anuncio['descricao'] ?? '', style: const TextStyle(fontSize: 15)),
                      const SizedBox(height: 12),
                    ],
                  ),
                if ((anuncio['detalhes'] ?? '').isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Detalhes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 4),
                      Text(anuncio['detalhes'] ?? '', style: const TextStyle(fontSize: 15)),
                      const SizedBox(height: 12),
                    ],
                  ),
                if ((anuncio['localizacao'] ?? '').isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Morada', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 4),
                      Text(anuncio['localizacao'] ?? '', style: const TextStyle(fontSize: 15)),
                      const SizedBox(height: 12),
                    ],
                  ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 22),
                    const SizedBox(width: 4),
                    Text('Ver avaliações', style: const TextStyle(color: Color(0xFF2A815E), fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.phone, color: Color(0xFF2A815E)),
                    const SizedBox(width: 4),
                    Text('Contactar vendedor', style: const TextStyle(color: Color(0xFF2A815E), fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
} 