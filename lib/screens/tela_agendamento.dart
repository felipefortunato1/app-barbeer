import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../models/servico.dart';
import 'package:barbeer/widgets/menu_drawer.dart';

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
      builder:
          (context, child) => Theme(
            data: ThemeData.dark(), // deixa o calendário escuro também
            child: child!,
          ),
    );
    if (escolhida != null) {
      setState(() => _dataSelecionada = escolhida);
    }
  }

  Future<void> _selecionarHora(BuildContext context) async {
    final TimeOfDay? escolhida = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) => Theme(data: ThemeData.dark(), child: child!),
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
      backgroundColor: Colors.black,
      drawer: buildMenuDrawer(context),
      appBar: AppBar(
        title: const Text('Agendar Horário'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.grey[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.servico.nome,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Preço: R\$ ${widget.servico.preco.toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    Text(
                      'Duração: ${widget.servico.duracao.inMinutes} minutos',
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            _secaoTitulo('Selecione a Data'),
            _botaoSelecao(
              label:
                  _dataSelecionada == null
                      ? 'Selecionar data'
                      : DateFormat('dd/MM/yyyy').format(_dataSelecionada!),
              onPressed: () => _selecionarData(context),
              icon: Icons.calendar_today,
            ),

            const SizedBox(height: 24),
            _secaoTitulo('Selecione o Horário'),
            _botaoSelecao(
              label:
                  _horaSelecionada == null
                      ? 'Selecionar horário'
                      : _horaSelecionada!.format(context),
              onPressed: () => _selecionarHora(context),
              icon: Icons.access_time,
            ),

            const SizedBox(height: 24),
            _secaoTitulo('Selecione o Barbeiro'),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              dropdownColor: Colors.grey[900],
              value: _barbeiroSelecionado,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white10,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              style: const TextStyle(color: Colors.white),
              iconEnabledColor: Colors.white,
              items:
                  _barbeiros.map((barbeiro) {
                    return DropdownMenuItem(
                      value: barbeiro,
                      child: Text(
                        barbeiro,
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
              onChanged:
                  (novoValor) =>
                      setState(() => _barbeiroSelecionado = novoValor),
            ),

            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _confirmarAgendamento,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                icon: const Icon(Icons.check_circle_outline),
                label: const Text(
                  'Confirmar Agendamento',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _secaoTitulo(String texto) {
    return Text(
      texto,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }

  Widget _botaoSelecao({
    required String label,
    required VoidCallback onPressed,
    required IconData icon,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.black),
      label: Text(label, style: const TextStyle(color: Colors.black)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}
