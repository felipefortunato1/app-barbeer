import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'screens/auth/tela_login.dart';
import 'screens/auth/tela_cadastro.dart';
import 'screens/auth/tela_recuperar_senha.dart';
import 'screens/tela_sobre.dart';
import 'screens/tela_servicos.dart';
import 'screens/tela_agendamento.dart';
import 'screens/tela_agendamentos.dart';
import 'screens/tela_perfil.dart';
import 'screens/tela_barbeiros.dart';
import 'utils/app_theme.dart';

import 'models/servico.dart';

void main() {
  runApp(const AppBarbeer());
}

final _rotas = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const TelaLogin()),
    GoRoute(
      path: '/cadastro',
      builder: (context, state) => const TelaCadastro(),
    ),
    GoRoute(
      path: '/recuperar-senha',
      builder: (context, state) => const TelaRecuperarSenha(),
    ),
    GoRoute(path: '/sobre', builder: (context, state) => const TelaSobre()),
    GoRoute(
      path: '/servicos',
      builder: (context, state) => const TelaServicos(),
    ),
    GoRoute(
      path: '/agendar',
      builder: (context, state) {
        final servico = state.extra as Servico;
        return TelaAgendamento(servico: servico);
      },
    ),
    GoRoute(
      path: '/meus-agendamentos',
      builder: (context, state) => const TelaAgendamentos(),
    ),
    GoRoute(path: '/perfil', builder: (context, state) => const TelaPerfil()),
    GoRoute(
      path: '/barbeiros',
      builder: (context, state) => const TelaBarbeiros(),
    ),
  ],
);

class AppBarbeer extends StatelessWidget {
  const AppBarbeer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'BarBeer',
      theme: AppTheme.darkTheme,
      routerConfig: _rotas,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
      locale: const Locale('pt', 'BR'),
    );
  }
}
