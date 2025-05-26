import 'package:flutter/material.dart';
import 'package:barbeer/widgets/menu_drawer.dart';

class TelaSobre extends StatelessWidget {
  const TelaSobre({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: buildMenuDrawer(context),
      appBar: AppBar(
        title: const Text('Sobre'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Objetivo do Aplicativo',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'O BarBeer é um aplicativo desenvolvido para facilitar o agendamento de serviços em barbearias, '
              'proporcionando uma experiência mais prática e eficiente tanto para os clientes quanto para os profissionais.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Equipe de Desenvolvimento',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            const ListTile(
              leading: Icon(Icons.person, color: Colors.white),
              title: Text(
                'Felipe Fortunato',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                'Desenvolvedor Flutter',
                style: TextStyle(color: Colors.white60),
              ),
            ),
            const SizedBox(height: 48),
            const Center(
              child: Text(
                'Versão 1.0.0',
                style: TextStyle(color: Colors.white38, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
