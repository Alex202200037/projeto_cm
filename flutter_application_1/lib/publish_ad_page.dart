import 'package:flutter/material.dart';

class PublishAdPage extends StatelessWidget {
  const PublishAdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2A815E),
        title: const Text('Publicar Anúncio', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text('Primeiro um título apelativo*'),
            TextField(decoration: InputDecoration(hintText: 'p. ex. Batatas Biológicas')),
            const SizedBox(height: 12),
            const Text('Categoria*'),
            TextField(decoration: InputDecoration(hintText: 'Categoria')),
            const SizedBox(height: 12),
            const Text('Descrição*'),
            TextField(maxLines: 3, decoration: InputDecoration(hintText: 'Escreve aqui a tua descrição')),
            const SizedBox(height: 12),
            const Text('Localização*'),
            TextField(decoration: InputDecoration(hintText: 'Freguesia ou Código Postal')),
            const SizedBox(height: 12),
            const Text('Selecione as opções de Entrega*'),
            SwitchListTile(title: Text('Ao Domicílio (Produtor)'), value: true, onChanged: null),
            SwitchListTile(title: Text('Recolha num local à escolha'), value: false, onChanged: null),
            SwitchListTile(title: Text('Realizada por Transportadora'), value: true, onChanged: null),
            const SizedBox(height: 12),
            const Text('Detalhes da Venda*'),
            TextField(decoration: InputDecoration(hintText: 'Quantidade Mínima')),
            const SizedBox(height: 12),
            const Text('Selecione a unidade de medida*'),
            Row(
              children: [
                Expanded(child: SwitchListTile(title: Text('KG'), value: true, onChanged: null)),
                Expanded(child: SwitchListTile(title: Text('Unidade'), value: false, onChanged: null)),
              ],
            ),
            const SizedBox(height: 12),
            const Text('Preço'),
            TextField(decoration: InputDecoration(hintText: 'Preço')),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade300),
                    onPressed: () {},
                    child: const Text('Cancelar', style: TextStyle(color: Colors.black)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF2A815E)),
                    onPressed: () {},
                    child: const Text('Publicar Anúncio'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 