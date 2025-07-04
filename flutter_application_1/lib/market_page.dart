import 'package:flutter/material.dart';
import 'hellofarmer_app_bar.dart';
import 'profile_drawer.dart';
import 'preferences_drawer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io';

class MarketPage extends StatefulWidget {
  final List<Map<String, dynamic>> anuncios;
  const MarketPage({Key? key, required this.anuncios}) : super(key: key);

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ImagePicker _picker = ImagePicker();
  String? _bancaImagePath;

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
                      child: _bancaImagePath != null 
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                File(_bancaImagePath!),
                                fit: BoxFit.cover,
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                'assets/quinta.jpg',
                                fit: BoxFit.cover,
                              ),
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
                    leading: _anuncioImage(ad['fotoUrl']),
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
      double? lat;
      double? lng;

      // 1. Tenta extrair lat/lng do campo 'detalhes'
      if (anuncio['detalhes'] != null && anuncio['detalhes'].toString().contains('Lat:')) {
        final regex = RegExp(r'Lat:\s*([\-\d.]+),\s*Lng:\s*([\-\d.]+)');
        final match = regex.firstMatch(anuncio['detalhes']);
        if (match != null) {
          lat = double.tryParse(match.group(1)!);
          lng = double.tryParse(match.group(2)!);
        }
      }

      // 2. Se não houver lat/lng, tenta geocoding do campo 'localizacao'
      if ((lat == null || lng == null) && anuncio['localizacao'] != null && anuncio['localizacao']!.isNotEmpty) {
        try {
          List<Location> locations = await locationFromAddress(anuncio['localizacao']!).timeout(const Duration(seconds: 7));
          if (locations.isNotEmpty) {
            lat = locations.first.latitude;
            lng = locations.first.longitude;
          }
        } catch (_) {
          // Ignora erros de geocoding
        }
      }

      // 3. Só adiciona marker se tiver coordenadas válidas
      if (lat != null && lng != null) {
        markers.add(
          Marker(
            markerId: MarkerId('${anuncio['titulo']}_${lat}_${lng}_${DateTime.now().millisecondsSinceEpoch}_${anuncio.hashCode}'),
            position: LatLng(lat, lng),
            icon: customIcon,
            infoWindow: InfoWindow(
              title: anuncio['titulo'] ?? '',
              snippet: anuncio['preco'] ?? '',
              onTap: () {
                _showAnuncioModal(anuncio);
              },
            ),
            onTap: () {
              _showAnuncioModal(anuncio);
            },
          ),
        );
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
    String? tempImagePath = _bancaImagePath;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
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
                    
                    // Seção da imagem
                    const Text('Imagem da Banca', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () async {
                        final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          setModalState(() {
                            tempImagePath = image.path;
                          });
                        }
                      },
                      child: Container(
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFF2A815E).withOpacity(0.3)),
                        ),
                        child: tempImagePath != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  File(tempImagePath!),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_photo_alternate,
                                    size: 40,
                                    color: const Color(0xFF2A815E).withOpacity(0.6),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Adicionar imagem',
                                    style: TextStyle(
                                      color: const Color(0xFF2A815E).withOpacity(0.6),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    TextField(
                      controller: nomeController,
                      decoration: const InputDecoration(
                        labelText: 'Nome',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: descricaoController,
                      decoration: const InputDecoration(
                        labelText: 'Descrição',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: localizacaoController,
                      decoration: const InputDecoration(
                        labelText: 'Localização',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: moradaController,
                      decoration: const InputDecoration(
                        labelText: 'Morada',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: mercadosController,
                      decoration: const InputDecoration(
                        labelText: 'Mercados (separados por vírgula)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade300,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancelar', style: TextStyle(color: Colors.black)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2A815E),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                _banca = {
                                  'nome': nomeController.text,
                                  'descricao': descricaoController.text,
                                  'localizacao': localizacaoController.text,
                                  'morada': moradaController.text,
                                  'mercados': mercadosController.text.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList(),
                                };
                                _bancaImagePath = tempImagePath;
                              });
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Banca atualizada com sucesso!'),
                                  backgroundColor: Color(0xFF2A815E),
                                ),
                              );
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

  Widget _anuncioImage(String? fotoUrl) {
    if (fotoUrl != null && fotoUrl.startsWith('assets/')) {
      return Image.asset(fotoUrl, fit: BoxFit.cover, height: 80, width: 80);
    } else if (fotoUrl != null && fotoUrl.isNotEmpty) {
      return Image.file(File(fotoUrl), fit: BoxFit.cover, height: 80, width: 80);
    }
    return const Icon(Icons.image, size: 80, color: Color(0xFFB0B0B0));
  }
} 