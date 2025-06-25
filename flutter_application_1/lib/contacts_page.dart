import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'hellofarmer_app_bar.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HelloFarmerAppBar(
        onProfilePressed: () {
          // Implementar perfil
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildContactInfo(),
            const SizedBox(height: 24),
            _buildContactForm(),
            const SizedBox(height: 24),
            _buildSocialMedia(),
            const SizedBox(height: 24),
            _buildFAQ(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
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
          const Icon(
            Icons.contact_support,
            color: Colors.white,
            size: 48,
          ),
          const SizedBox(height: 12),
          const Text(
            'Contacte-nos',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            'Estamos aqui para ajudar! Entre em contacto connosco através de qualquer um dos métodos abaixo.',
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

  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Informações de Contacto',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1B4B38),
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.2,
          children: [
            _buildContactCard(
              icon: Icons.phone,
              title: 'Telefone',
              subtitle: '+351 123 456 789',
              color: const Color(0xFF4CAF50),
              onTap: () => _makePhoneCall(),
            ),
            _buildContactCard(
              icon: Icons.email,
              title: 'Email',
              subtitle: 'suporte@hellofarmer.pt',
              color: const Color(0xFF2196F3),
              onTap: () => _sendEmail(),
            ),
            _buildContactCard(
              icon: Icons.location_on,
              title: 'Endereço',
              subtitle: 'Lisboa, Portugal',
              color: const Color(0xFFFF9800),
              onTap: () => _openMaps(),
            ),
            _buildContactCard(
              icon: Icons.access_time,
              title: 'Horário',
              subtitle: 'Seg-Sex: 9h-18h',
              color: const Color(0xFF9C27B0),
              onTap: () => _showWorkingHours(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String subtitle,
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
              style: const TextStyle(
                color: Color(0xFF1B4B38),
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                color: const Color(0xFF2A815E).withOpacity(0.7),
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactForm() {
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
            'Envie-nos uma Mensagem',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B4B38),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Nome Completo',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person, color: Color(0xFF2A815E)),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email, color: Color(0xFF2A815E)),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _subjectController,
            decoration: const InputDecoration(
              labelText: 'Assunto',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.subject, color: Color(0xFF2A815E)),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _messageController,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'Mensagem',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.message, color: Color(0xFF2A815E)),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _submitContactForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2A815E),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Enviar Mensagem',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialMedia() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Redes Sociais',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1B4B38),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildSocialButton(
              icon: Icons.facebook,
              label: 'Facebook',
              color: const Color(0xFF1877F2),
              onTap: () => _openSocialMedia('facebook'),
            ),
            _buildSocialButton(
              icon: Icons.chat,
              label: 'WhatsApp',
              color: const Color(0xFF25D366),
              onTap: () => _openWhatsApp(),
            ),
            _buildSocialButton(
              icon: Icons.telegram,
              label: 'Telegram',
              color: const Color(0xFF0088CC),
              onTap: () => _openSocialMedia('telegram'),
            ),
            _buildSocialButton(
              icon: Icons.camera_alt,
              label: 'Instagram',
              color: const Color(0xFFE4405F),
              onTap: () => _openSocialMedia('instagram'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF1B4B38),
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQ() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Perguntas Frequentes',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1B4B38),
          ),
        ),
        const SizedBox(height: 16),
        _buildFAQItem(
          question: 'Como posso publicar um anúncio?',
          answer: 'Para publicar um anúncio, aceda à secção "Banca" e clique no botão "+" para criar um novo anúncio.',
        ),
        _buildFAQItem(
          question: 'Como funciona o sistema de pagamentos?',
          answer: 'Aceitamos pagamentos através de transferência bancária, dinheiro ou cartão de crédito/débito.',
        ),
        _buildFAQItem(
          question: 'Posso cancelar uma encomenda?',
          answer: 'Sim, pode cancelar uma encomenda até 24 horas antes da entrega programada.',
        ),
        _buildFAQItem(
          question: 'Como funciona a entrega?',
          answer: 'A entrega é feita diretamente pelo agricultor ou através dos nossos parceiros de logística.',
        ),
      ],
    );
  }

  Widget _buildFAQItem({required String question, required String answer}) {
    return ExpansionTile(
      title: Text(
        question,
        style: const TextStyle(
          color: Color(0xFF1B4B38),
          fontWeight: FontWeight.w600,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            answer,
            style: const TextStyle(
              color: Color(0xFF2A815E),
            ),
          ),
        ),
      ],
    );
  }

  void _makePhoneCall() async {
    const phoneNumber = 'tel:+351123456789';
    if (await canLaunchUrl(Uri.parse(phoneNumber))) {
      await launchUrl(Uri.parse(phoneNumber));
    } else {
      _showErrorSnackBar('Não foi possível fazer a chamada');
    }
  }

  void _sendEmail() async {
    const email = 'mailto:suporte@hellofarmer.pt?subject=Suporte HelloFarmer';
    if (await canLaunchUrl(Uri.parse(email))) {
      await launchUrl(Uri.parse(email));
    } else {
      _showErrorSnackBar('Não foi possível abrir o email');
    }
  }

  void _openMaps() async {
    const address = 'https://maps.google.com/?q=Lisboa,Portugal';
    if (await canLaunchUrl(Uri.parse(address))) {
      await launchUrl(Uri.parse(address));
    } else {
      _showErrorSnackBar('Não foi possível abrir o mapa');
    }
  }

  void _showWorkingHours() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Horário de Funcionamento'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Segunda a Sexta: 9h00 - 18h00'),
            Text('Sábado: 9h00 - 13h00'),
            Text('Domingo: Encerrado'),
            SizedBox(height: 16),
            Text('Feriados: Encerrado'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  void _openWhatsApp() async {
    const whatsappUrl = 'https://wa.me/351123456789?text=Olá! Preciso de ajuda com a HelloFarmer.';
    if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
      await launchUrl(Uri.parse(whatsappUrl));
    } else {
      _showErrorSnackBar('Não foi possível abrir o WhatsApp');
    }
  }

  void _openSocialMedia(String platform) {
    String url;
    switch (platform) {
      case 'facebook':
        url = 'https://facebook.com/hellofarmer';
        break;
      case 'instagram':
        url = 'https://instagram.com/hellofarmer';
        break;
      case 'telegram':
        url = 'https://t.me/hellofarmer';
        break;
      default:
        url = 'https://hellofarmer.pt';
    }
    
    launchUrl(Uri.parse(url)).catchError((_) {
      _showErrorSnackBar('Não foi possível abrir o $platform');
    });
  }

  void _submitContactForm() {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _subjectController.text.isEmpty ||
        _messageController.text.isEmpty) {
      _showErrorSnackBar('Por favor, preencha todos os campos');
      return;
    }

    // Aqui implementaria o envio real do formulário
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Mensagem enviada com sucesso! Entraremos em contacto em breve.'),
        backgroundColor: Color(0xFF2A815E),
      ),
    );

    // Limpar formulário
    _nameController.clear();
    _emailController.clear();
    _subjectController.clear();
    _messageController.clear();
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
} 