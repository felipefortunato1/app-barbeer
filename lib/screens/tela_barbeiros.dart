import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
      appBar: AppBar(title: const Text('Barbeiros')),
      body: ListView.builder(
        itemCount: _barbeiros.length,
        itemBuilder: (context, index) {
          final barbeiro = _barbeiros[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(radius: 30),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          barbeiro.nome,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(barbeiro.especialidade),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16,
                            ),
                            Text(' ${barbeiro.avaliacao}'),
                            const SizedBox(width: 8),
                            Text('(${barbeiro.totalAvaliacoes} avaliações)'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => context.push('/servicos'),
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
