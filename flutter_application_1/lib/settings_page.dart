import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'hellofarmer_app_bar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _locationEnabled = true;
  String _selectedLanguage = 'Português';
  double _fontSize = 16.0;

  final List<String> _languages = ['Português', 'English', 'Español'];

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
            _buildAccountSection(),
            const SizedBox(height: 24),
            _buildPreferencesSection(),
            const SizedBox(height: 24),
            _buildAppSettingsSection(),
            const SizedBox(height: 24),
            _buildSupportSection(),
            const SizedBox(height: 24),
            _buildAboutSection(),
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
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.white,
            radius: 30,
            child: Icon(
              Icons.settings,
              color: Color(0xFF2A815E),
              size: 35,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Definições',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Personalize a sua experiência',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSection() {
    return _buildSection(
      title: 'Conta',
      icon: Icons.person,
      children: [
        _buildSettingTile(
          icon: Icons.email,
          title: 'Email',
          subtitle: FirebaseAuth.instance.currentUser?.email ?? 'Não definido',
          onTap: () {
            _showEditDialog('Email', FirebaseAuth.instance.currentUser?.email ?? '');
          },
        ),
        _buildSettingTile(
          icon: Icons.phone,
          title: 'Telefone',
          subtitle: '+351 123 456 789',
          onTap: () {
            _showEditDialog('Telefone', '+351 123 456 789');
          },
        ),
        _buildSettingTile(
          icon: Icons.location_on,
          title: 'Localização',
          subtitle: 'Lisboa, Portugal',
          onTap: () {
            _showEditDialog('Localização', 'Lisboa, Portugal');
          },
        ),
        _buildSettingTile(
          icon: Icons.business,
          title: 'Nome da Quinta',
          subtitle: 'Quinta do João',
          onTap: () {
            _showEditDialog('Nome da Quinta', 'Quinta do João');
          },
        ),
      ],
    );
  }

  Widget _buildPreferencesSection() {
    return _buildSection(
      title: 'Preferências',
      icon: Icons.tune,
      children: [
        _buildSwitchTile(
          icon: Icons.notifications,
          title: 'Notificações',
          subtitle: 'Receber alertas e notificações',
          value: _notificationsEnabled,
          onChanged: (value) {
            setState(() {
              _notificationsEnabled = value;
            });
          },
        ),
        _buildSwitchTile(
          icon: Icons.dark_mode,
          title: 'Modo Escuro',
          subtitle: 'Ativar tema escuro',
          value: _darkModeEnabled,
          onChanged: (value) {
            setState(() {
              _darkModeEnabled = value;
            });
          },
        ),
        _buildSettingTile(
          icon: Icons.language,
          title: 'Idioma',
          subtitle: _selectedLanguage,
          onTap: () {
            _showLanguageDialog();
          },
        ),
        _buildSettingTile(
          icon: Icons.text_fields,
          title: 'Tamanho da Fonte',
          subtitle: '${_fontSize.round()}px',
          onTap: () {
            _showFontSizeDialog();
          },
        ),
      ],
    );
  }

  Widget _buildAppSettingsSection() {
    return _buildSection(
      title: 'Configurações da App',
      icon: Icons.app_settings_alt,
      children: [
        _buildSwitchTile(
          icon: Icons.location_on,
          title: 'Localização',
          subtitle: 'Permitir acesso à localização',
          value: _locationEnabled,
          onChanged: (value) {
            setState(() {
              _locationEnabled = value;
            });
          },
        ),
        _buildSettingTile(
          icon: Icons.storage,
          title: 'Armazenamento',
          subtitle: '2.3 GB utilizados',
          onTap: () {
            _showStorageInfo();
          },
        ),
        _buildSettingTile(
          icon: Icons.security,
          title: 'Privacidade',
          subtitle: 'Gerir permissões',
          onTap: () {
            _showPrivacySettings();
          },
        ),
        _buildSettingTile(
          icon: Icons.backup,
          title: 'Backup',
          subtitle: 'Último backup: hoje',
          onTap: () {
            _showBackupOptions();
          },
        ),
      ],
    );
  }

  Widget _buildSupportSection() {
    return _buildSection(
      title: 'Suporte',
      icon: Icons.help,
      children: [
        _buildSettingTile(
          icon: Icons.help_center,
          title: 'Centro de Ajuda',
          subtitle: 'Perguntas frequentes',
          onTap: () {
            _showHelpCenter();
          },
        ),
        _buildSettingTile(
          icon: Icons.contact_support,
          title: 'Contactar Suporte',
          subtitle: 'Fale connosco',
          onTap: () {
            _showContactSupport();
          },
        ),
        _buildSettingTile(
          icon: Icons.bug_report,
          title: 'Reportar Problema',
          subtitle: 'Enviar feedback',
          onTap: () {
            _showBugReport();
          },
        ),
        _buildSettingTile(
          icon: Icons.rate_review,
          title: 'Avaliar App',
          subtitle: 'Deixe a sua opinião',
          onTap: () {
            _showRatingDialog();
          },
        ),
      ],
    );
  }

  Widget _buildAboutSection() {
    return _buildSection(
      title: 'Sobre',
      icon: Icons.info,
      children: [
        _buildSettingTile(
          icon: Icons.info_outline,
          title: 'Versão',
          subtitle: '1.0.0',
          onTap: null,
        ),
        _buildSettingTile(
          icon: Icons.description,
          title: 'Termos de Serviço',
          subtitle: 'Ler termos',
          onTap: () {
            _showTermsOfService();
          },
        ),
        _buildSettingTile(
          icon: Icons.privacy_tip,
          title: 'Política de Privacidade',
          subtitle: 'Ler política',
          onTap: () {
            _showPrivacyPolicy();
          },
        ),
        _buildSettingTile(
          icon: Icons.logout,
          title: 'Terminar Sessão',
          subtitle: 'Sair da conta',
          onTap: () async {
            await FirebaseAuth.instance.signOut();
            if (mounted) {
              Navigator.of(context).popUntil((route) => route.isFirst);
            }
          },
          textColor: Colors.red,
        ),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: const Color(0xFF2A815E), size: 24),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B4B38),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback? onTap,
    Color? textColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF2A815E)),
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? const Color(0xFF1B4B38),
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: textColor?.withOpacity(0.7) ?? const Color(0xFF2A815E).withOpacity(0.7),
        ),
      ),
      trailing: onTap != null ? const Icon(Icons.chevron_right, color: Color(0xFF2A815E)) : null,
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF2A815E)),
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF1B4B38),
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: const Color(0xFF2A815E).withOpacity(0.7),
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: const Color(0xFF2A815E),
      ),
    );
  }

  void _showEditDialog(String field, String currentValue) {
    final controller = TextEditingController(text: currentValue);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Editar $field'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: field,
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              // Aqui implementaria a lógica para salvar
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$field atualizado com sucesso!')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2A815E),
              foregroundColor: Colors.white,
            ),
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Selecionar Idioma'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: _languages.map((language) {
            return ListTile(
              title: Text(language),
              trailing: _selectedLanguage == language
                  ? const Icon(Icons.check, color: Color(0xFF2A815E))
                  : null,
              onTap: () {
                setState(() {
                  _selectedLanguage = language;
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showFontSizeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tamanho da Fonte'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Slider(
              value: _fontSize,
              min: 12,
              max: 24,
              divisions: 12,
              label: '${_fontSize.round()}px',
              onChanged: (value) {
                setState(() {
                  _fontSize = value;
                });
              },
            ),
            Text(
              'Texto de exemplo',
              style: TextStyle(fontSize: _fontSize),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Tamanho da fonte atualizado!')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2A815E),
              foregroundColor: Colors.white,
            ),
            child: const Text('Aplicar'),
          ),
        ],
      ),
    );
  }

  void _showStorageInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Informações de Armazenamento'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Imagens: 1.2 GB'),
            Text('Dados da app: 0.8 GB'),
            Text('Cache: 0.3 GB'),
            SizedBox(height: 16),
            Text('Total: 2.3 GB / 4.0 GB'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cache limpo!')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2A815E),
              foregroundColor: Colors.white,
            ),
            child: const Text('Limpar Cache'),
          ),
        ],
      ),
    );
  }

  void _showPrivacySettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Configurações de Privacidade'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Localização'),
              subtitle: Text('Permitir acesso à localização'),
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Câmara'),
              subtitle: Text('Permitir acesso à câmara'),
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Galeria'),
              subtitle: Text('Permitir acesso à galeria'),
            ),
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

  void _showBackupOptions() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Opções de Backup'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.backup),
              title: Text('Backup Automático'),
              subtitle: Text('Diariamente às 02:00'),
            ),
            ListTile(
              leading: Icon(Icons.cloud_upload),
              title: Text('Backup na Nuvem'),
              subtitle: Text('Google Drive'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Backup iniciado!')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2A815E),
              foregroundColor: Colors.white,
            ),
            child: const Text('Fazer Backup'),
          ),
        ],
      ),
    );
  }

  void _showHelpCenter() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Centro de Ajuda'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.question_answer),
              title: Text('Como publicar um anúncio?'),
            ),
            ListTile(
              leading: Icon(Icons.question_answer),
              title: Text('Como gerir as minhas vendas?'),
            ),
            ListTile(
              leading: Icon(Icons.question_answer),
              title: Text('Como contactar o suporte?'),
            ),
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

  void _showContactSupport() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Contactar Suporte'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.email),
              title: Text('Email'),
              subtitle: Text('suporte@hellofarmer.pt'),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Telefone'),
              subtitle: Text('+351 123 456 789'),
            ),
            ListTile(
              leading: Icon(Icons.chat),
              title: Text('Chat Online'),
              subtitle: Text('Disponível 24/7'),
            ),
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

  void _showBugReport() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reportar Problema'),
        content: TextField(
          controller: controller,
          maxLines: 4,
          decoration: const InputDecoration(
            labelText: 'Descreva o problema',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Problema reportado! Obrigado pelo feedback.')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2A815E),
              foregroundColor: Colors.white,
            ),
            child: const Text('Enviar'),
          ),
        ],
      ),
    );
  }

  void _showRatingDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Avaliar HelloFarmer'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Como avalia a sua experiência?'),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.star, color: Colors.amber, size: 30),
                Icon(Icons.star, color: Colors.amber, size: 30),
                Icon(Icons.star, color: Colors.amber, size: 30),
                Icon(Icons.star, color: Colors.amber, size: 30),
                Icon(Icons.star_border, color: Colors.amber, size: 30),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Obrigado pela sua avaliação!')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2A815E),
              foregroundColor: Colors.white,
            ),
            child: const Text('Enviar'),
          ),
        ],
      ),
    );
  }

  void _showTermsOfService() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Termos de Serviço'),
        content: const SingleChildScrollView(
          child: Text(
            'Ao utilizar a aplicação HelloFarmer, concorda com os nossos termos de serviço...',
          ),
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

  void _showPrivacyPolicy() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Política de Privacidade'),
        content: const SingleChildScrollView(
          child: Text(
            'A sua privacidade é importante para nós. Esta política descreve como recolhemos, utilizamos e protegemos os seus dados...',
          ),
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
}
