# HelloFarmer

**O Futuro do Agricultor** - Uma aplicação móvel desenvolvida em Flutter para conectar agricultores diretamente aos consumidores.

## Sobre o Projeto

A **HelloFarmer** é uma plataforma digital que elimina intermediários na comercialização de produtos agrícolas, permitindo aos agricultores vender diretamente aos consumidores através de uma interface intuitiva e moderna.

## Funcionalidades Principais

### **Página Inicial**
- Dashboard personalizado com recomendações
- Acesso rápido às funcionalidades principais
- Sistema de notificações integrado
- Interface centrada e responsiva

### **Gestão de Vendas**
- Controlo de encomendas pendentes e entregues
- Sistema de entrega na morada ou recolha por transportadora
- Gestão de clientes e histórico de vendas
- Interface de cartões com informações detalhadas

### **Banca/Anúncios**
- Publicação de anúncios de produtos agrícolas
- Categorização por tipo (Cereais, Hortícolas, Tubérculos)
- Sistema de preços e detalhes dos produtos
- Destaque de anúncios especiais
- Gestão de anúncios ativos e expirados

### **Gestão e Análise**
- Dashboard completo com métricas de vendas
- Análise de dados por período
- Gestão financeira e controlo de despesas
- Relatórios de produtos mais vendidos
- Gráficos interativos (barras, pizza, linha)

### **Notificações**
- Sistema de notificações em tempo real
- Alertas sobre encomendas e produtos
- Gestão de notificações importantes

### **Configurações**
- Gestão de perfil do agricultor
- Configurações de pagamento e logística
- Personalização da experiência
- Gestão de conta e permissões

### **Perfil do Utilizador**
- Informações pessoais do agricultor
- Histórico de atividades
- Configurações de privacidade

## Tecnologias Utilizadas

- **Frontend:** Flutter (Dart)
- **Backend:** Firebase (Firestore, Authentication)
- **Design:** Material Design 3
- **Plataforma:** Android/iOS
- **Estado:** StatefulWidget e State Management
- **Navegação:** Bottom Navigation Bar

## Pré-requisitos

- Flutter SDK (versão 3.0 ou superior)
- Dart SDK
- Android Studio / VS Code
- Emulador Android ou dispositivo físico
- Conta Firebase (para funcionalidades de backend)

## Instalação

### 1. **Clone o Repositório**
```bash
git clone [URL_DO_REPOSITÓRIO]
cd flutter_application_1
```

### 2. **Instale as Dependências**
```bash
flutter pub get
```

### 3. **Configure o Firebase** (Opcional)
- Crie um projeto no Firebase Console
- Adicione as configurações do Firebase
- Configure o Firestore Database

### 4. **Execute a Aplicação**
```bash
flutter run
```

## Como Usar

### **Primeira Execução**
1. A aplicação inicia com uma tela de splash
2. Após 2 segundos, navega para a página inicial
3. Use o menu lateral para aceder às funcionalidades
4. Use a barra de navegação inferior para alternar entre páginas

### **Navegação**
- **Início:** Dashboard principal com recomendações
- **Vendas:** Gestão de encomendas e entregas
- **Banca:** Publicação e gestão de anúncios
- **Notificações:** Sistema de alertas
- **Gestão:** Análise de dados e configurações

### **Funcionalidades Principais**
- **Publicar Anúncio:** Aceda à Banca e clique em "Publicar"
- **Ver Encomendas:** Aceda a Vendas para ver pedidos
- **Análise de Dados:** Aceda a Gestão para ver métricas
- **Configurações:** Use o menu lateral ou perfil

## Design e Interface

### **Cores Principais**
- **Verde Principal:** `#2A815E`
- **Verde Escuro:** `#1B4B38`
- **Verde Claro:** `#F2F5F3`
- **Branco:** `#FFFFFF`

### **Componentes Reutilizáveis**
- `HelloFarmerAppBar`: Barra de navegação superior
- `PreferencesDrawer`: Menu lateral
- `ProfileDrawer`: Menu do perfil
- Cards personalizados para diferentes funcionalidades

## Estrutura do Projeto

```
lib/
├── main.dart                          # Ponto de entrada da aplicação
├── splash_screen.dart                 # Tela de inicialização
├── auth_landing_page.dart             # Página de autenticação
├── login_page.dart                    # Página de login
├── sign_up_page.dart                  # Página de registo
├── welcome_page.dart                  # Página inicial
├── sales_page.dart                    # Gestão de vendas
├── market_page.dart                   # Banca e anúncios
├── management_page.dart               # Gestão e análise
├── notifications_page.dart            # Sistema de notificações
├── settings_page.dart                 # Configurações
├── contacts_page.dart                 # Página de contactos
├── user_profile_page.dart             # Perfil do utilizador
├── publish_ad_page.dart               # Publicação de anúncios
├── hellofarmer_app_bar.dart           # Barra de navegação superior
├── preferences_drawer.dart            # Menu lateral
├── profile_drawer.dart                # Menu do perfil
├── firebase_service.dart              # Serviços Firebase
├── notification_service.dart          # Serviços de notificação
├── main_navigation_controller.dart    # Controlador de navegação
└── populate_firestore.dart            # População de dados de teste
```

## Configuração do Desenvolvimento

### **Estrutura de Dados**
- **Utilizadores:** Perfis de agricultores
- **Produtos:** Anúncios de produtos agrícolas
- **Encomendas:** Pedidos e entregas
- **Notificações:** Sistema de alertas

### **Serviços**
- **Firebase Service:** Gestão de dados
- **Notification Service:** Sistema de notificações
- **Navigation Controller:** Controlo de navegação

## Autores

- **Alexandre Miguel** - 202200037
- **António Guerreiro** - 202200106
- **Bruna Rossa** - 202200603

---

**"Conectando Agricultores ao Futuro Digital"** 
