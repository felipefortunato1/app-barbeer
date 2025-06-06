import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../models/servico.dart';
import '../widgets/menu_drawer.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_card.dart';
import '../utils/app_theme.dart';

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

  // Horários de funcionamento
  final TimeOfDay _horarioInicio = const TimeOfDay(hour: 9, minute: 0);
  final TimeOfDay _horarioFim = const TimeOfDay(hour: 18, minute: 0);

  // Horários já agendados (simulado)
  final List<DateTime> _horariosOcupados = [
    DateTime.now().add(const Duration(days: 1, hours: 10)),
    DateTime.now().add(const Duration(days: 1, hours: 14)),
    DateTime.now().add(const Duration(days: 2, hours: 11)),
  ];

  final List<String> _barbeiros = const [
    'João Silva',
    'Pedro Santos',
    'Carlos Oliveira',
  ];

  List<TimeOfDay> _getHorariosDisponiveis() {
    if (_dataSelecionada == null) return [];

    final List<TimeOfDay> horarios = [];
    final now = DateTime.now();
    final dataAtual = DateTime(now.year, now.month, now.day);
    final dataSelecionada = DateTime(
      _dataSelecionada!.year,
      _dataSelecionada!.month,
      _dataSelecionada!.day,
    );

    // Se a data selecionada for hoje, começa do horário atual
    TimeOfDay inicio = _horarioInicio;
    if (dataSelecionada.isAtSameMomentAs(dataAtual)) {
      final horaAtual = TimeOfDay.fromDateTime(now);
      if (horaAtual.hour > _horarioInicio.hour) {
        inicio = TimeOfDay(
          hour: horaAtual.hour,
          minute: ((horaAtual.minute ~/ 30) + 1) * 30,
        );
      }
    }

    // Gera horários de 30 em 30 minutos
    for (var hora = inicio.hour; hora < _horarioFim.hour; hora++) {
      for (var minuto = 0; minuto < 60; minuto += 30) {
        final horario = TimeOfDay(hour: hora, minute: minuto);
        final dataHora = DateTime(
          _dataSelecionada!.year,
          _dataSelecionada!.month,
          _dataSelecionada!.day,
          horario.hour,
          horario.minute,
        );

        // Verifica se o horário não está ocupado
        bool horarioDisponivel = true;
        for (var ocupado in _horariosOcupados) {
          if (dataHora.isAtSameMomentAs(ocupado)) {
            horarioDisponivel = false;
            break;
          }
        }

        if (horarioDisponivel) {
          horarios.add(horario);
        }
      }
    }

    return horarios;
  }

  Future<void> _selecionarData(BuildContext context) async {
    final DateTime? escolhida = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      locale: const Locale('pt', 'BR'),
      builder: (context, child) => Theme(data: ThemeData.dark(), child: child!),
    );
    if (escolhida != null) {
      setState(() {
        _dataSelecionada = escolhida;
        _horaSelecionada = null; // Reseta o horário ao mudar a data
      });
    }
  }

  void _selecionarHora(TimeOfDay horario) {
    setState(() => _horaSelecionada = horario);
  }

  void _confirmarAgendamento() {
    if (_dataSelecionada == null ||
        _horaSelecionada == null ||
        _barbeiroSelecionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha todos os campos'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Aqui você pode adicionar a lógica para salvar o agendamento
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Agendamento realizado com sucesso!'),
        backgroundColor: Colors.green,
      ),
    );
    context.go('/meus-agendamentos');
  }

  @override
  Widget build(BuildContext context) {
    final horariosDisponiveis = _getHorariosDisponiveis();
    final dateFormat = DateFormat('dd/MM/yyyy', 'pt_BR');

    return Scaffold(
      drawer: buildMenuDrawer(context),
      appBar: AppBar(
        title: const Text('Agendar Horário'),
        elevation: 0,
        backgroundColor: AppTheme.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.paddingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'servico_${widget.servico.nome}',
              child: CustomCard(
                child: Padding(
                  padding: const EdgeInsets.all(AppTheme.paddingMedium),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.cut,
                            color: AppTheme.accentColor,
                            size: 24,
                          ),
                          const SizedBox(width: AppTheme.paddingSmall),
                          Expanded(
                            child: Text(
                              widget.servico.nome,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppTheme.paddingMedium),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Preço',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white70,
                                  ),
                                ),
                                Text(
                                  'R\$ ${widget.servico.preco.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: AppTheme.paddingMedium),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text(
                                  'Duração',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white70,
                                  ),
                                ),
                                Text(
                                  '${widget.servico.duracao.inMinutes} min',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppTheme.paddingLarge),

            Text('Selecione a Data', style: AppTheme.titleStyle),
            const SizedBox(height: AppTheme.paddingSmall),
            CustomButton(
              text:
                  _dataSelecionada == null
                      ? 'Selecionar data'
                      : dateFormat.format(_dataSelecionada!),
              onPressed: () => _selecionarData(context),
              icon: Icons.calendar_today,
            ),

            if (_dataSelecionada != null) ...[
              const SizedBox(height: AppTheme.paddingLarge),
              Text('Horários Disponíveis', style: AppTheme.titleStyle),
              const SizedBox(height: AppTheme.paddingMedium),
              Wrap(
                spacing: AppTheme.paddingSmall,
                runSpacing: AppTheme.paddingSmall,
                children:
                    horariosDisponiveis.map((horario) {
                      final isSelected = _horaSelecionada == horario;
                      return CustomButton(
                        text: horario.format(context),
                        onPressed: () => _selecionarHora(horario),
                        isOutlined: !isSelected,
                      );
                    }).toList(),
              ),
            ],

            const SizedBox(height: AppTheme.paddingLarge),
            Text('Selecione o Barbeiro', style: AppTheme.titleStyle),
            const SizedBox(height: AppTheme.paddingSmall),
            Container(
              decoration: BoxDecoration(
                color: AppTheme.surfaceDark,
                borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                border: Border.all(
                  color: AppTheme.accentColor.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: DropdownButtonFormField<String>(
                value: _barbeiroSelecionado,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.paddingMedium,
                  ),
                  hintText: 'Escolha um barbeiro',
                  hintStyle: const TextStyle(color: Colors.white54),
                ),
                dropdownColor: AppTheme.surfaceDark,
                style: const TextStyle(fontSize: 16, color: Colors.white),
                iconEnabledColor: AppTheme.textPrimary,
                items:
                    _barbeiros.map((barbeiro) {
                      return DropdownMenuItem(
                        value: barbeiro,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.person,
                              size: 20,
                              color: Colors.white70,
                            ),
                            const SizedBox(width: AppTheme.paddingSmall),
                            Text(barbeiro),
                          ],
                        ),
                      );
                    }).toList(),
                onChanged:
                    (novoValor) =>
                        setState(() => _barbeiroSelecionado = novoValor),
              ),
            ),

            const SizedBox(height: AppTheme.paddingLarge),
            CustomButton(
              text: 'Confirmar Agendamento',
              onPressed: _confirmarAgendamento,
              icon: Icons.check_circle_outline,
            ),
          ],
        ),
      ),
    );
  }
}
