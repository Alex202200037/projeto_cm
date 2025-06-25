import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final firestore = FirebaseFirestore.instance;

  final anuncios = [
    {
      'titulo': 'Cereais Biológicos',
      'categoria': 'Cereais',
      'descricao': 'Cereais frescos, colheita local, produção sustentável.',
      'localizacao': 'Comporta, Alcácer do Sal',
      'detalhes': 'Lat: 38.3786, Lng: -8.7857',
      'preco': '15€/saco',
      'fotoUrl': '',
      'userId': 'demo',
      'createdAt': FieldValue.serverTimestamp(),
    },
    {
      'titulo': 'Batatas Novas',
      'categoria': 'Batatas',
      'descricao': 'Batatas colhidas hoje, ideais para assar ou cozer.',
      'localizacao': 'Comporta, Alcácer do Sal',
      'detalhes': 'Lat: 38.3800, Lng: -8.7840',
      'preco': '10€/saco',
      'fotoUrl': '',
      'userId': 'demo',
      'createdAt': FieldValue.serverTimestamp(),
    },
    {
      'titulo': 'Tomates de Verão',
      'categoria': 'Tomates',
      'descricao': 'Tomates maduros, perfeitos para saladas.',
      'localizacao': 'Comporta, Alcácer do Sal',
      'detalhes': 'Lat: 38.3770, Lng: -8.7865',
      'preco': '3€/kg',
      'fotoUrl': '',
      'userId': 'demo',
      'createdAt': FieldValue.serverTimestamp(),
    },
    {
      'titulo': 'Cenouras Doces',
      'categoria': 'Cenouras',
      'descricao': 'Cenouras frescas, crocantes e doces.',
      'localizacao': 'Comporta, Alcácer do Sal',
      'detalhes': 'Lat: 38.3795, Lng: -8.7830',
      'preco': '2€/kg',
      'fotoUrl': '',
      'userId': 'demo',
      'createdAt': FieldValue.serverTimestamp(),
    },
  ];

  for (final anuncio in anuncios) {
    await firestore.collection('anuncios').add(anuncio);
  }

  print('População concluída!');
  // Fecha a app automaticamente após popular
  Future.delayed(const Duration(seconds: 2), () => Future.sync(() => WidgetsBinding.instance.handlePopRoute()));
}
