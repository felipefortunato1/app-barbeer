import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _EstadoTelaCadastro();
}

class _EstadoTelaCadastro extends State<TelaCadastro> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _carregando = false;

  void _cadastrar() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final dados = _formKey.currentState!.value;

      if (dados['senha'] != dados['confirmarSenha']) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('As senhas não coincidem!')),
        );
        return;
      }

      setState(() => _carregando = true);

      Future.delayed(const Duration(seconds: 2), () {
        setState(() => _carregando = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cadastro realizado com sucesso!')),
        );
        context.go('/login');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Criar Conta'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                'Bem-vindo à BarBeer',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Preencha os dados abaixo para criar sua conta',
                style: TextStyle(color: Colors.white60, fontSize: 14),
              ),
              const SizedBox(height: 32),

              _input('nome', 'Nome completo', Icons.person),
              const SizedBox(height: 16),

              _input(
                'email',
                'E-mail',
                Icons.email,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                ]),
              ),
              const SizedBox(height: 16),

              _input('telefone', 'Telefone', Icons.phone),
              const SizedBox(height: 16),

              _input(
                'senha',
                'Senha',
                Icons.lock,
                obscure: true,
                isSenha: true,
              ),
              const SizedBox(height: 16),

              _input(
                'confirmarSenha',
                'Confirmar Senha',
                Icons.lock,
                obscure: true,
              ),
              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: _carregando ? null : _cadastrar,
                  child:
                      _carregando
                          ? const CircularProgressIndicator(color: Colors.black)
                          : const Text(
                            'Cadastrar',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => context.pop(),
                style: TextButton.styleFrom(foregroundColor: Colors.white70),
                child: const Text('Já tem uma conta? Faça login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _input(
    String nome,
    String label,
    IconData icone, {
    bool obscure = false,
    bool isSenha = false,
    String? Function(String?)? validator,
  }) {
    return FormBuilderTextField(
      name: nome,
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      validator: validator ?? FormBuilderValidators.required(),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white10,
        prefixIcon: Icon(icone, color: Colors.white),
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
}
