import 'package:flutter/material.dart';
import 'hellofarmer_app_bar.dart';
import 'user_profile_page.dart';
import 'preferences_drawer.dart';
import 'profile_drawer.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key, this.currentIndex = 0, this.onTabSelected});

  final int currentIndex;
  final ValueChanged<int>? onTabSelected;

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListView(
          children: [
            const SizedBox(height: 12),
            const Text(
              'Bem Vind@ à HelloFarmer!',
              style: TextStyle(
                color: Color(0xFF1B4B38),
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Divider(height: 32, thickness: 1.2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Expanded(
                  child: Text(
                    'Recomendados para si...',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B4B38),
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    'Ver mais',
                    style: TextStyle(
                      color: Color(0xFF2A815E),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
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
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _recommendationCardWithImage(
                    'Preços das Embalagens na Região',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Estes são os possíveis Parceiros/Fornecedores que achamos que poderão ser úteis...',
              style: TextStyle(color: Color(0xFF1B4B38), fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Divider(height: 32, thickness: 1.2),
            const SizedBox(height: 8),
            const Text(
              'Alguma Dúvida?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Color(0xFF1B4B38),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Entre em contacto connosco!',
              style: TextStyle(color: Color(0xFF2A815E), fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  static Widget _recommendationCardWithImage(String title) {
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
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.image,
                size: 48,
                color: Color(0xFFB0B0B0),
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
