import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../models/servico.dart';
import '../widgets/menu_drawer.dart';
import '../widgets/custom_card.dart';
import '../widgets/custom_button.dart';
import '../utils/app_theme.dart';

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

  void _cancelarAgendamento(BuildContext context, Agendamento agendamento) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: AppTheme.surfaceDark,
            title: const Text(
              'Cancelar Agendamento',
              style: AppTheme.titleStyle,
            ),
            content: const Text(
              'Tem certeza que deseja cancelar este agendamento?',
              style: AppTheme.bodyStyle,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Não'),
              ),
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Agendamento cancelado com sucesso!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.pop(context);
                },
                child: const Text('Sim'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy', 'pt_BR');

    return Scaffold(
      drawer: buildMenuDrawer(context),
      appBar: AppBar(title: const Text('Meus Agendamentos')),
      body:
          _agendamentos.isEmpty
              ? Center(
                child: Text(
                  'Nenhum agendamento encontrado',
                  style: AppTheme.bodyStyle,
                ),
              )
              : ListView.builder(
                itemCount: _agendamentos.length,
                itemBuilder: (context, index) {
                  final agendamento = _agendamentos[index];
                  return CustomCard(
                    margin: const EdgeInsets.symmetric(
                      horizontal: AppTheme.paddingMedium,
                      vertical: AppTheme.paddingSmall,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          agendamento.servico.nome,
                          style: AppTheme.titleStyle,
                        ),
                        const SizedBox(height: AppTheme.paddingSmall),
                        Text(
                          'Barbeiro: ${agendamento.barbeiro}',
                          style: AppTheme.bodyStyle,
                        ),
                        Text(
                          'Data: ${dateFormat.format(agendamento.data)}',
                          style: AppTheme.bodyStyle,
                        ),
                        Text(
                          'Horário: ${agendamento.horario.format(context)}',
                          style: AppTheme.bodyStyle,
                        ),
                        Text(
                          'Preço: R\$ ${agendamento.servico.preco.toStringAsFixed(2)}',
                          style: AppTheme.bodyStyle,
                        ),
                        const SizedBox(height: AppTheme.paddingSmall),
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
                            const SizedBox(width: AppTheme.paddingSmall),
                            Text(
                              agendamento.finalizado ? 'Concluído' : 'Pendente',
                              style: TextStyle(
                                color:
                                    agendamento.finalizado
                                        ? Colors.green
                                        : Colors.orange,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (!agendamento.finalizado) ...[
                              const Spacer(),
                              IconButton(
                                icon: const Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                ),
                                onPressed:
                                    () => _cancelarAgendamento(
                                      context,
                                      agendamento,
                                    ),
                              ),
                            ],
                          ],
                        ),
                      ],
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
