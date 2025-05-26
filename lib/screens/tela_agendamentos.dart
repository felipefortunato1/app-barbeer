import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../models/servico.dart';
import 'package:barbeer/widgets/menu_drawer.dart';

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
      backgroundColor: Colors.black,
      drawer: buildMenuDrawer(context),
      appBar: AppBar(
        title: const Text('Meus Agendamentos'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body:
          _agendamentos.isEmpty
              ? const Center(
                child: Text(
                  'Nenhum agendamento encontrado',
                  style: TextStyle(color: Colors.white70),
                ),
              )
              : ListView.builder(
                itemCount: _agendamentos.length,
                itemBuilder: (context, index) {
                  final agendamento = _agendamentos[index];
                  return Card(
                    color: Colors.grey[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      title: Text(
                        agendamento.servico.nome,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Barbeiro: ${agendamento.barbeiro}',
                              style: const TextStyle(color: Colors.white70),
                            ),
                            Text(
                              'Data: ${DateFormat('dd/MM/yyyy').format(agendamento.data)}',
                              style: const TextStyle(color: Colors.white70),
                            ),
                            Text(
                              'Horário: ${agendamento.horario.format(context)}',
                              style: const TextStyle(color: Colors.white70),
                            ),
                            Text(
                              'Preço: R\$ ${agendamento.servico.preco.toStringAsFixed(2)}',
                              style: const TextStyle(color: Colors.white70),
                            ),
                            Row(
                              children: [
                                Icon(
                                  agendamento.finalizado
                                      ? Icons.check_circle
                                      : Icons.access_time,
                                  color:
                                      agendamento.finalizado
                                          ? Colors.green
                                          : Colors.orange,
                                  size: 18,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  agendamento.finalizado
                                      ? 'Concluído'
                                      : 'Pendente',
                                  style: TextStyle(
                                    color:
                                        agendamento.finalizado
                                            ? Colors.green
                                            : Colors.orange,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      trailing:
                          agendamento.finalizado
                              ? null
                              : IconButton(
                                icon: const Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder:
                                        (context) => AlertDialog(
                                          backgroundColor: Colors.grey[900],
                                          title: const Text(
                                            'Cancelar Agendamento',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          content: const Text(
                                            'Tem certeza que deseja cancelar este agendamento?',
                                            style: TextStyle(
                                              color: Colors.white70,
                                            ),
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
