import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:barbeer/widgets/menu_drawer.dart';

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
            backgroundColor: Colors.grey[900],
            title: const Text(
              'Confirmar saída',
              style: TextStyle(color: Colors.white),
            ),
            content: const Text(
              'Deseja realmente sair do aplicativo?',
              style: TextStyle(color: Colors.white70),
            ),
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
      backgroundColor: Colors.black,
      drawer: buildMenuDrawer(context),
      appBar: AppBar(
        title: const Text('Meu Perfil'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          if (!_editando)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => setState(() => _editando = true),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: FormBuilder(
          key: _formKey,
          initialValue: _valoresIniciais,
          enabled: _editando,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.6),
                      blurRadius: 10,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white12,
                  child: Icon(Icons.person, size: 50, color: Colors.white),
                ),
              ),
              const SizedBox(height: 24),

              _inputField('nome', 'Nome', Icons.person),
              const SizedBox(height: 16),

              _inputField(
                'email',
                'E-mail',
                Icons.email,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                ]),
              ),
              const SizedBox(height: 16),

              _inputField('telefone', 'Telefone', Icons.phone),
              const SizedBox(height: 32),

              if (_editando) ...[
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _carregando ? null : _salvarPerfil,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child:
                        _carregando
                            ? const CircularProgressIndicator(
                              color: Colors.black,
                            )
                            : const Text(
                              'Salvar',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
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
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white54),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 32),
              const Divider(color: Colors.white24),

              _listTile(
                Icons.calendar_today,
                'Meus Agendamentos',
                '/meus-agendamentos',
              ),
              _listTile(Icons.info_outline, 'Sobre', '/sobre'),
              _listTile(Icons.logout, 'Sair', null, onTap: _confirmarLogout),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField(
    String name,
    String label,
    IconData icon, {
    String? Function(String?)? validator,
  }) {
    return FormBuilderTextField(
      name: name,
      validator: validator ?? FormBuilderValidators.required(),
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.white),
        filled: true,
        fillColor: Colors.white10,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.white30),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.white),
        ),
      ),
    );
  }

  Widget _listTile(
    IconData icon,
    String title,
    String? route, {
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap:
          onTap ??
          () {
            if (route != null) context.push(route);
          },
    );
  }
}
