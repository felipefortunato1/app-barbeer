import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Drawer buildMenuDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(color: Colors.black),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              CircleAvatar(radius: 30, child: Icon(Icons.person, size: 30)),
              SizedBox(height: 12),
              Text(
                'Bem-vindo!',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Perfil'),
          onTap: () => context.push('/perfil'),
        ),
        ListTile(
          leading: const Icon(Icons.calendar_today),
          title: const Text('Meus Compromissos'),
          onTap: () => context.push('/meus-agendamentos'),
        ),
        ListTile(
          leading: const Icon(Icons.notifications),
          title: const Text('Notificações'),
          onTap: () => context.push('/notificacoes'),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Sair'),
          onTap: () {
            Navigator.pop(context);
            showDialog(
              context: context,
              builder:
                  (ctx) => AlertDialog(
                    title: const Text('Deseja sair?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                          context.go('/login');
                        },
                        child: const Text('Sair'),
                      ),
                    ],
                  ),
            );
          },
        ),
      ],
    ),
  );
}
