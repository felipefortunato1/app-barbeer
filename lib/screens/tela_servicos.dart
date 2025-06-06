import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/servico.dart';
import '../widgets/menu_drawer.dart';
import '../widgets/custom_card.dart';
import '../widgets/custom_button.dart';
import '../utils/app_theme.dart';

class TelaServicos extends StatelessWidget {
  const TelaServicos({super.key});

  final List<Servico> _servicos = const [
    Servico(
      nome: 'Corte Masculino',
      descricao: 'Corte moderno e estilizado',
      preco: 35.00,
      duracao: Duration(minutes: 30),
    ),
    Servico(
      nome: 'Limpeza de Rosto',
      descricao: 'Higienização e hidratação',
      preco: 30.00,
      duracao: Duration(minutes: 25),
    ),
    Servico(
      nome: 'Sobrancelha',
      descricao: 'Design e limpeza de sobrancelha',
      preco: 15.00,
      duracao: Duration(minutes: 15),
    ),
    Servico(
      nome: 'Barba',
      descricao: 'Aparo e modelagem da barba',
      preco: 25.00,
      duracao: Duration(minutes: 20),
    ),
  ];

  String _getImagemServico(String nome) {
    if (nome.contains('Corte')) return 'img/servico_corte.png';
    if (nome.contains('Limpeza')) return 'img/servico_sobrancelha.JPG';
    if (nome.contains('Sobrancelha')) return 'img/servico_sobrancelha.jpg';
    return 'img/servico_barba.jpg';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildMenuDrawer(context),
      appBar: AppBar(
        title: const Text('Serviços'),
        elevation: 0,
        backgroundColor: AppTheme.primaryColor,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppTheme.secondaryColor,
                  AppTheme.secondaryColor.withOpacity(0.8),
                ],
              ),
            ),
            padding: const EdgeInsets.all(AppTheme.paddingLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Nossos Serviços',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: AppTheme.paddingSmall),
                const Text(
                  'Escolha o serviço desejado e agende seu horário',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                const SizedBox(height: AppTheme.paddingLarge),
                Hero(
                  tag: 'servico_header',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                    child: Image.asset(
                      'img/servico_limpeza2.png',
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              color: AppTheme.backgroundDark,
              padding: const EdgeInsets.all(AppTheme.paddingMedium),
              child: ListView.separated(
                itemCount: _servicos.length,
                separatorBuilder:
                    (_, __) => const SizedBox(height: AppTheme.paddingMedium),
                itemBuilder: (context, index) {
                  final servico = _servicos[index];
                  final imagem = _getImagemServico(servico.nome);
                  return Hero(
                    tag: 'servico_${servico.nome}',
                    child: CustomCard(
                      child: InkWell(
                        onTap: () => context.push('/agendar', extra: servico),
                        borderRadius: BorderRadius.circular(
                          AppTheme.borderRadius,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(AppTheme.paddingMedium),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  AppTheme.borderRadius,
                                ),
                                child: Image.asset(
                                  imagem,
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppTheme.paddingMedium,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        servico.nome,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: AppTheme.paddingSmall,
                                      ),
                                      Text(
                                        servico.descricao,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white70,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: AppTheme.paddingSmall,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'R\$ ${servico.preco.toStringAsFixed(2)}',
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                '${servico.duracao.inMinutes} min',
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white60,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 100,
                                            child: CustomButton(
                                              text: 'Agendar',
                                              onPressed:
                                                  () => context.push(
                                                    '/agendar',
                                                    extra: servico,
                                                  ),
                                              icon: Icons.calendar_today,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        backgroundColor: AppTheme.primaryColor,
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
