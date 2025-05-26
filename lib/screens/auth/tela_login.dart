import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _EstadoTelaLogin();
}

class _EstadoTelaLogin extends State<TelaLogin> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _carregando = false;

  void _fazerLogin() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      setState(() => _carregando = true);

      Future.delayed(const Duration(seconds: 2), () {
        setState(() => _carregando = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login realizado com sucesso!')),
        );
        context.go('/servicos');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset('img/logo2.JPG', height: 120),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Ismene',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Agende seu estilo com um clique',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 40),
              FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    _input(
                      nome: 'email',
                      label: 'E-mail',
                      icone: Icons.email_outlined,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.email(),
                      ]),
                    ),
                    const SizedBox(height: 16),
                    _input(
                      nome: 'senha',
                      label: 'Senha',
                      icone: Icons.lock_outline,
                      obscure: true,
                      validator: FormBuilderValidators.required(),
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
                        onPressed: _carregando ? null : _fazerLogin,
                        child:
                            _carregando
                                ? const CircularProgressIndicator(
                                  color: Colors.black,
                                )
                                : const Text(
                                  'Entrar',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () => context.push('/cadastro'),
                      child: const Text('Ainda não tem conta? Cadastre-se'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white70,
                      ),
                    ),
                    TextButton(
                      onPressed: () => context.push('/recuperar-senha'),
                      child: const Text('Esqueceu sua senha?'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _input({
    required String nome,
    required String label,
    required IconData icone,
    bool obscure = false,
    String? Function(String?)? validator,
  }) {
    return FormBuilderTextField(
      name: nome,
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
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
      validator: validator,
    );
  }
}
