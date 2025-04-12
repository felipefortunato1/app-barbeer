import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

class TelaPerfil extends StatefulWidget {
  const TelaPerfil({super.key});

  @override
  State<TelaPerfil> createState() => _EstadoTelaPerfil();
}

class _EstadoTelaPerfil extends State<TelaPerfil> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _editando = false;
  bool _carregando = false;

  final Map<String, dynamic> _valoresIniciais = {
    'nome': 'Usuário Teste',
    'email': 'usuario@teste.com',
    'telefone': '(11) 99999-9999',
  };

  void _salvarPerfil() {
    if (_formKey.currentState?.saveAndValidate() ?? false) return;

    setState(() => _carregando = true);

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _carregando = false;
        _editando = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Perfil atualizado com sucesso!')),
      );
    });
  }

  void _confirmarLogout() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Confirmar saída'),
            content: const Text('Deseja realmente sair do aplicativo?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Logout realizado com sucesso!'),
                    ),
                  );
                  context.go('/login');
                },
                child: const Text('Sair'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        actions: [
          if (!_editando)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => setState(() => _editando = true),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          initialValue: _valoresIniciais,
          enabled: _editando,
          child: Column(
            children: [
              const CircleAvatar(
                radius: 50,
                child: Icon(Icons.person, size: 50),
              ),
              const SizedBox(height: 24),
              FormBuilderTextField(
                name: 'nome',
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: FormBuilderValidators.required(),
              ),
              const SizedBox(height: 16),
              FormBuilderTextField(
                name: 'email',
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                ]),
              ),
              const SizedBox(height: 16),
              FormBuilderTextField(
                name: 'telefone',
                decoration: const InputDecoration(
                  labelText: 'Telefone',
                  prefixIcon: Icon(Icons.phone),
                ),
                validator: FormBuilderValidators.required(),
              ),
              const SizedBox(height: 32),
              if (_editando) ...[
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _carregando ? null : _salvarPerfil,
                    child:
                        _carregando
                            ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                            : const Text('Salvar'),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed:
                        _carregando
                            ? null
                            : () => setState(() => _editando = false),
                    child: const Text('Cancelar'),
                  ),
                ),
              ],
              const SizedBox(height: 32),
              ListTile(
                leading: const Icon(Icons.calendar_today),
                title: const Text('Meus Agendamentos'),
                onTap: () => context.push('/meus-agendamentos'),
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('Sobre'),
                onTap: () => context.push('/sobre'),
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Sair'),
                onTap: _confirmarLogout,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
