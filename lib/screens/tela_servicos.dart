import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/servico.dart';
import 'package:barbeer/widgets/menu_drawer.dart';

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
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.cut), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
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
              context.go('/perfil');
              break;
          }
        },
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: const Color.fromARGB(255, 94, 98, 100),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Serviços',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'img/servico_limpeza2.png',
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.black,
              padding: const EdgeInsets.all(16),
              child: ListView.separated(
                itemCount: _servicos.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final servico = _servicos[index];
                  final imagem = _getImagemServico(servico.nome);
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            bottomLeft: Radius.circular(16),
                          ),
                          child: Image.asset(
                            imagem,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  servico.nome,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  servico.descricao,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'R\$ ${servico.preco.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                          255,
                                          164,
                                          174,
                                          180,
                                        ),
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                      ),
                                      onPressed:
                                          () => context.push(
                                            '/agendar',
                                            extra: servico,
                                          ),
                                      child: const Text('Agendar'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
