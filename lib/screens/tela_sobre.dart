import 'package:flutter/material.dart';

class TelaSobre extends StatelessWidget {
  const TelaSobre({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sobre')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Objetivo do Aplicativo',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'O BarBeer é um aplicativo desenvolvido para facilitar o agendamento de serviços em barbearias, '
              'proporcionando uma experiência mais prática e eficiente tanto para os clientes quanto para os profissionais.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),
            const Text(
              'Equipe de Desenvolvimento',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const ListTile(
              leading: Icon(Icons.person),
              title: Text('Felipe Fortunato'),
              subtitle: Text('Desenvolvedor Flutter'),
            ),
            const Spacer(),
            const Center(
              child: Text(
                'Versão 1.0.0',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
