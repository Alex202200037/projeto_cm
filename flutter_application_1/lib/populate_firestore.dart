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
      'fotoUrl': 'assets/grao.jpg',
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
      'fotoUrl': 'assets/batatas.jpg',
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
      'fotoUrl': 'assets/tomates.jpg',
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
      'fotoUrl': 'assets/cenouras.jpg',
      'userId': 'demo',
      'createdAt': FieldValue.serverTimestamp(),
    },
    {
      'titulo': 'Alface Fresca',
      'categoria': 'Alface',
      'descricao': 'Alface crocante, colhida hoje.',
      'localizacao': 'Comporta, Alcácer do Sal',
      'detalhes': 'Lat: 38.3810, Lng: -8.7820',
      'preco': '1€/unidade',
      'fotoUrl': 'assets/alface.jpg',
      'userId': 'demo',
      'createdAt': FieldValue.serverTimestamp(),
    },
    {
      'titulo': 'Couves do Campo',
      'categoria': 'Couves',
      'descricao': 'Couves verdes, ideais para caldo.',
      'localizacao': 'Comporta, Alcácer do Sal',
      'detalhes': 'Lat: 38.3820, Lng: -8.7810',
      'preco': '2€/kg',
      'fotoUrl': 'assets/couves.jpg',
      'userId': 'demo',
      'createdAt': FieldValue.serverTimestamp(),
    },
    {
      'titulo': 'Ervilhas Doces',
      'categoria': 'Ervilhas',
      'descricao': 'Ervilhas tenras e doces, perfeitas para sopas.',
      'localizacao': 'Comporta, Alcácer do Sal',
      'detalhes': 'Lat: 38.3830, Lng: -8.7800',
      'preco': '3€/kg',
      'fotoUrl': 'assets/ervilhas.jpg',
      'userId': 'demo',
      'createdAt': FieldValue.serverTimestamp(),
    },
    {
      'titulo': 'Quinta da Alegria',
      'categoria': 'Quinta',
      'descricao': 'Produtos variados da Quinta da Alegria.',
      'localizacao': 'Azeitão',
      'detalhes': 'Lat: 38.3840, Lng: -8.7790',
      'preco': 'Sob consulta',
      'fotoUrl': 'assets/quinta.jpg',
      'userId': 'demo',
      'createdAt': FieldValue.serverTimestamp(),
    },
    {
      'titulo': 'Terreno para Cultivo',
      'categoria': 'Terreno',
      'descricao': 'Terreno fértil disponível para arrendamento.',
      'localizacao': 'Comporta, Alcácer do Sal',
      'detalhes': 'Lat: 38.3850, Lng: -8.7780',
      'preco': 'Sob consulta',
      'fotoUrl': 'assets/terreno.jpg',
      'userId': 'demo',
      'createdAt': FieldValue.serverTimestamp(),
    },
  ];

  for (final anuncio in anuncios) {
    final query = await firestore
        .collection('anuncios')
        .where('titulo', isEqualTo: anuncio['titulo'])
        .get();
    if (query.docs.isEmpty) {
      await firestore.collection('anuncios').add(anuncio);
    }
  }

  print('População concluída!');
  // Fecha a app automaticamente após popular
  Future.delayed(const Duration(seconds: 2), () => Future.sync(() => WidgetsBinding.instance.handlePopRoute()));
}
