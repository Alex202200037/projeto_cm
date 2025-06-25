import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'hellofarmer_app_bar.dart';
import 'user_profile_page.dart';
import 'preferences_drawer.dart';
import 'profile_drawer.dart';
import 'management_page.dart';
import 'market_page.dart';
import 'sales_page.dart';
import 'notifications_page.dart';
import 'publish_ad_page.dart';
import 'main_navigation_controller.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key, this.currentIndex = 0, this.onTabSelected});

  final int currentIndex;
  final ValueChanged<int>? onTabSelected;

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final List<String> _farmImages = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _addFarmImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _farmImages.add(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: HelloFarmerAppBar(
        onProfilePressed: () {
          showProfileDrawer(context);
        },
      ),
      drawer: PreferencesDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            _buildWelcomeHeader(),
            const SizedBox(height: 20),
            _buildQuickActions(),
            const SizedBox(height: 24),
            _buildFarmImagesSection(),
            const SizedBox(height: 24),
            _buildRecommendationsSection(),
            const SizedBox(height: 24),
            _buildStatsSection(),
            const SizedBox(height: 24),
            _buildContactSection(),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2A815E), Color(0xFF1B4B38)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Bem Vind@ à HelloFarmer! 🌱',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            'A sua plataforma completa para gestão agrícola',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ações Rápidas',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1B4B38),
          ),
        ),
        const SizedBox(height: 12),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.2,
          children: [
            _buildActionCard(
              icon: Icons.add_circle,
              title: 'Publicar Anúncio',
              color: const Color(0xFF2A815E),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  builder: (context) => PublishAdModal(),
                );
              },
            ),
            _buildActionCard(
              icon: Icons.shopping_cart,
              title: 'Ver Vendas',
              color: const Color(0xFF4CAF50),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/');
                Future.delayed(const Duration(milliseconds: 100), () {
                  MainNavigationController().changeTab?.call(1);
                });
              },
            ),
            _buildActionCard(
              icon: Icons.agriculture,
              title: 'Mercado',
              color: const Color(0xFFFF9800),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/');
                Future.delayed(const Duration(milliseconds: 100), () {
                  MainNavigationController().changeTab?.call(2);
                });
              },
            ),
            _buildActionCard(
              icon: Icons.settings,
              title: 'Gestão',
              color: const Color(0xFF2196F3),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/');
                Future.delayed(const Duration(milliseconds: 100), () {
                  MainNavigationController().changeTab?.call(4);
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 32,
                color: color,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: const Color(0xFF1B4B38),
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFarmImagesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Imagens da Quinta',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B4B38),
              ),
            ),
            TextButton.icon(
              onPressed: _addFarmImage,
              icon: const Icon(Icons.add_photo_alternate, color: Color(0xFF2A815E)),
              label: const Text(
                'Adicionar',
                style: TextStyle(color: Color(0xFF2A815E), fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (_farmImages.isEmpty)
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF2F5F3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF2A815E).withOpacity(0.3), style: BorderStyle.solid),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.photo_library,
                  size: 40,
                  color: const Color(0xFF2A815E).withOpacity(0.6),
                ),
                const SizedBox(height: 8),
                Text(
                  'Adicione fotos da sua quinta',
                  style: TextStyle(
                    color: const Color(0xFF2A815E).withOpacity(0.6),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          )
        else
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _farmImages.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 120,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      children: [
                        Image.file(
                          File(_farmImages[index]),
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _farmImages.removeAt(index);
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildRecommendationsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recomendados para si...',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B4B38),
                fontSize: 20,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MarketPage(anuncios: [])),
                );
              },
              child: const Text(
                'Ver mais',
                style: TextStyle(
                  color: Color(0xFF2A815E),
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _recommendationCardWithImage(
                'Preços de Sistema de Irrigação na Região',
                'assets/tractor.jpg',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _recommendationCardWithImage(
                'Preços das Embalagens na Região',
                'assets/cesta.jpg',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F5F3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Estatísticas da Semana',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B4B38),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatCard('Vendas', '€1,250', Icons.euro),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard('Encomendas', '15', Icons.shopping_bag),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard('Produtos', '8', Icons.inventory),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF2A815E), size: 24),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B4B38),
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF2A815E),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2A815E), Color(0xFF1B4B38)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Text(
            'Alguma Dúvida?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            'Entre em contacto connosco!',
            style: TextStyle(color: Colors.white70, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildContactButton(
                icon: Icons.phone,
                label: 'Telefone',
                onTap: () {
                  // Implementar chamada telefónica
                },
              ),
              _buildContactButton(
                icon: Icons.email,
                label: 'Email',
                onTap: () {
                  // Implementar envio de email
                },
              ),
              _buildContactButton(
                icon: Icons.chat,
                label: 'Chat',
                onTap: () {
                  // Implementar chat
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _recommendationCardWithImage(String title, String imagePath) {
    return Card(
      color: const Color(0xFFF2F5F3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        height: 160,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 80,
              width: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF1B4B38),
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

