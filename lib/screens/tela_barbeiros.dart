import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:barbeer/widgets/menu_drawer.dart';

class Barbeiro {
  final String nome;
  final String especialidade;
  final double avaliacao;
  final int totalAvaliacoes;

  const Barbeiro({
    required this.nome,
    required this.especialidade,
    required this.avaliacao,
    required this.totalAvaliacoes,
  });
}

class TelaBarbeiros extends StatelessWidget {
  const TelaBarbeiros({super.key});

  final List<Barbeiro> _barbeiros = const [
    Barbeiro(
      nome: 'João Silva',
      especialidade: 'Corte Clássico e Barba',
      avaliacao: 4.8,
      totalAvaliacoes: 156,
    ),
    Barbeiro(
      nome: 'Pedro Santos',
      especialidade: 'Corte Moderno',
      avaliacao: 4.9,
      totalAvaliacoes: 203,
    ),
    Barbeiro(
      nome: 'Carlos Oliveira',
      especialidade: 'Barba e Pigmentação',
      avaliacao: 4.7,
      totalAvaliacoes: 98,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: buildMenuDrawer(context),
      appBar: AppBar(
        title: const Text('Barbeiros'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: _barbeiros.length,
        itemBuilder: (context, index) {
          final barbeiro = _barbeiros[index];
          return Card(
            color: Colors.grey[900],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white12,
                    child: Text(
                      barbeiro.nome[0],
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          barbeiro.nome,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          barbeiro.especialidade,
                          style: const TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${barbeiro.avaliacao}',
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '(${barbeiro.totalAvaliacoes} avaliações)',
                              style: const TextStyle(color: Colors.white60),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => context.push('/servicos'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('Agendar'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.cut), label: 'Serviços'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Agendamentos',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Barbeiros'),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/servicos');
              break;
            case 1:
              context.go('/meus-agendamentos');
              break;
            case 2:
              context.go('/barbeiros');
              break;
          }
        },
      ),
    );
  }
}
