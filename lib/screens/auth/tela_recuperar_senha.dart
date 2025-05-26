import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

class TelaRecuperarSenha extends StatefulWidget {
  const TelaRecuperarSenha({super.key});

  @override
  State<TelaRecuperarSenha> createState() => _EstadoTelaRecuperarSenha();
}

class _EstadoTelaRecuperarSenha extends State<TelaRecuperarSenha> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _carregando = false;

  void _enviarFormulario() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      setState(() => _carregando = true);

      Future.delayed(const Duration(seconds: 2), () {
        setState(() => _carregando = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('E-mail de recuperação enviado!')),
        );
        context.pop(); // Volta para o login
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Recuperar Senha'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.lock_reset, color: Colors.white70, size: 80),
                const SizedBox(height: 16),
                const Text(
                  'Esqueceu a senha?',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Digite seu e-mail e enviaremos instruções para redefinir sua senha.',
                  style: TextStyle(color: Colors.white60, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                FormBuilderTextField(
                  name: 'email',
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    labelStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.white10,
                    prefixIcon: const Icon(Icons.email, color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.white30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                      errorText: 'Campo obrigatório',
                    ),
                    FormBuilderValidators.email(errorText: 'E-mail inválido'),
                  ]),
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
                    onPressed: _carregando ? null : _enviarFormulario,
                    child:
                        _carregando
                            ? const CircularProgressIndicator(
                              color: Colors.black,
                            )
                            : const Text(
                              'Enviar',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => context.pop(),
                  style: TextButton.styleFrom(foregroundColor: Colors.white70),
                  child: const Text('Voltar para o login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
