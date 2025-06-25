import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  // Chama isto no início da app (ex: main.dart)
  static Future<void> initialize(BuildContext context) async {
    // Pede permissões (importante para iOS, mas também para Android 13+)
    await _messaging.requestPermission();

    // Obter o token do dispositivo (podes guardar na base de dados para enviar notificações)
    String? token = await _messaging.getToken();
    print('FCM Token: $token');

    // Handler para notificações recebidas em foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        final notification = message.notification!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${notification.title ?? ''}\n${notification.body ?? ''}')),
        );
      }
    });

    // Handler para quando a notificação abre a app
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Aqui podes navegar para uma página específica, se quiseres
      print('Notificação abriu a app: \\${message.data}');
    });
  }
}
