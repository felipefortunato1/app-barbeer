import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../models/servico.dart';

class Agendamento {
  final Servico servico;
  final DateTime data;
  final TimeOfDay horario;
  final String barbeiro;
  final bool finalizado;

  Agendamento({
    required this.servico,
    required this.data,
    required this.horario,
    required this.barbeiro,
    this.finalizado = false,
  });
}

class TelaAgendamentos extends StatefulWidget {
  const TelaAgendamentos({super.key});

  @override
  State<TelaAgendamentos> createState() => _EstadoTelaAgendamentos();
}

class _EstadoTelaAgendamentos extends State<TelaAgendamentos> {
  final List<Agendamento> _agendamentos = [
    Agendamento(
      servico: Servico(
        nome: 'Corte de Cabelo',
        descricao: 'Corte moderno e estilizado',
        preco: 35.00,
        duracao: const Duration(minutes: 30),
      ),
      data: DateTime(2024, 4, 15),
      horario: const TimeOfDay(hour: 14, minute: 30),
      barbeiro: 'João Silva',
    ),
    Agendamento(
      servico: Servico(
        nome: 'Barba',
        descricao: 'Aparo e modelagem da barba',
        preco: 25.00,
        duracao: const Duration(minutes: 20),
      ),
      data: DateTime(2024, 4, 20),
      horario: const TimeOfDay(hour: 10, minute: 0),
      barbeiro: 'Pedro Santos',
      finalizado: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meus Agendamentos')),
      body:
          _agendamentos.isEmpty
              ? const Center(child: Text('Nenhum agendamento encontrado'))
              : ListView.builder(
                itemCount: _agendamentos.length,
                itemBuilder: (context, index) {
                  final agendamento = _agendamentos[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: ListTile(
                      title: Text(
                        agendamento.servico.nome,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Barbeiro: ${agendamento.barbeiro}'),
                          Text(
                            'Data: ${DateFormat('dd/MM/yyyy').format(agendamento.data)}',
                          ),
                          Text(
                            'Horário: ${agendamento.horario.format(context)}',
                          ),
                          Text(
                            'Preço: R\$ ${agendamento.servico.preco.toStringAsFixed(2)}',
                          ),
                          Text(
                            'Status: ${agendamento.finalizado ? 'Concluído' : 'Pendente'}',
                            style: TextStyle(
                              color:
                                  agendamento.finalizado
                                      ? Colors.green
                                      : Colors.orange,
                            ),
                          ),
                        ],
                      ),
                      trailing:
                          agendamento.finalizado
                              ? null
                              : IconButton(
                                icon: const Icon(Icons.cancel),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder:
                                        (context) => AlertDialog(
                                          title: const Text(
                                            'Cancelar Agendamento',
                                          ),
                                          content: const Text(
                                            'Tem certeza que deseja cancelar este agendamento?',
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed:
                                                  () => Navigator.pop(context),
                                              child: const Text('Não'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                      'Agendamento cancelado com sucesso!',
                                                    ),
                                                  ),
                                                );
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Sim'),
                                            ),
                                          ],
                                        ),
                                  );
                                },
                              ),
                    ),
                  );
                },
              ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
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
