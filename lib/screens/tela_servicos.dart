import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/servico.dart';

class TelaServicos extends StatelessWidget {
  const TelaServicos({super.key});

  final List<Servico> _servicos = const [
    Servico(
      nome: 'Corte de Cabelo',
      descricao: 'Corte moderno e estilizado',
      preco: 35.00,
      duracao: Duration(minutes: 30),
    ),
    Servico(
      nome: 'Barba',
      descricao: 'Aparo e modelagem da barba',
      preco: 25.00,
      duracao: Duration(minutes: 20),
    ),
    Servico(
      nome: 'Corte + Barba',
      descricao: 'Corte de cabelo e barba',
      preco: 50.00,
      duracao: Duration(minutes: 45),
    ),
    Servico(
      nome: 'Hidratação',
      descricao: 'Hidratação profunda para cabelo e barba',
      preco: 40.00,
      duracao: Duration(minutes: 30),
    ),
    Servico(
      nome: 'Pigmentação',
      descricao: 'Coloração da barba',
      preco: 45.00,
      duracao: Duration(minutes: 40),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Serviços'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => context.push('/perfil'),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _servicos.length,
        itemBuilder: (context, index) {
          final servico = _servicos[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    servico.nome,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(servico.descricao),
                  Text(
                    'Duração: ${servico.duracao.inMinutes} minutos',
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'R\$ ${servico.preco.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                        ),
                        onPressed:
                            () => context.push('/agendar', extra: servico),
                        child: const Text('Agendar'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
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
