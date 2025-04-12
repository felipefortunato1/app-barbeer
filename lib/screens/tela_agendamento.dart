import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../models/servico.dart';

class TelaAgendamento extends StatefulWidget {
  const TelaAgendamento({super.key, required this.servico});

  final Servico servico;

  @override
  State<TelaAgendamento> createState() => _EstadoTelaAgendamento();
}

class _EstadoTelaAgendamento extends State<TelaAgendamento> {
  DateTime? _dataSelecionada;
  TimeOfDay? _horaSelecionada;
  String? _barbeiroSelecionado;

  final List<String> _barbeiros = const [
    'João Silva',
    'Pedro Santos',
    'Carlos Oliveira',
  ];

  Future<void> _selecionarData(BuildContext context) async {
    final DateTime? escolhida = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (escolhida != null) {
      setState(() => _dataSelecionada = escolhida);
    }
  }

  Future<void> _selecionarHora(BuildContext context) async {
    final TimeOfDay? escolhida = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (escolhida != null) {
      setState(() => _horaSelecionada = escolhida);
    }
  }

  void _confirmarAgendamento() {
    if (_dataSelecionada == null ||
        _horaSelecionada == null ||
        _barbeiroSelecionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Agendamento realizado com sucesso!')),
    );
    context.go('/meus-agendamentos');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agendar Horário')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.servico.nome,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Preço: R\$ ${widget.servico.preco.toStringAsFixed(2)}',
                    ),
                    Text(
                      'Duração: ${widget.servico.duracao.inMinutes} minutos',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Selecione a Data',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => _selecionarData(context),
              child: Text(
                _dataSelecionada == null
                    ? 'Selecionar data'
                    : DateFormat('dd/MM/yyyy').format(_dataSelecionada!),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Selecione o Horário',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => _selecionarHora(context),
              child: Text(
                _horaSelecionada == null
                    ? 'Selecionar horário'
                    : _horaSelecionada!.format(context),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Selecione o Barbeiro',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _barbeiroSelecionado,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
              items:
                  _barbeiros.map((barbeiro) {
                    return DropdownMenuItem(
                      value: barbeiro,
                      child: Text(barbeiro),
                    );
                  }).toList(),
              onChanged:
                  (novoValor) =>
                      setState(() => _barbeiroSelecionado = novoValor),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _confirmarAgendamento,
                child: const Text('Confirmar Agendamento'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
