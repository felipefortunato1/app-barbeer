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
  final _chaveFormulario = GlobalKey<FormBuilderState>();
  bool _carregando = false;

  void _enviarFormulario() {
    if (_chaveFormulario.currentState?.saveAndValidate() ?? false) {
      setState(() => _carregando = true);

      Future.delayed(const Duration(seconds: 2), () {
        setState(() => _carregando = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('E-mail de recuperação enviado!')),
        );
        context.pop(); // Volta para a tela anterior (login)
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recuperar Senha')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _chaveFormulario,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Digite seu e-mail para receber as instruções de recuperação de senha',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              FormBuilderTextField(
                name: 'email',
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: 'Campo obrigatório',
                  ),
                  FormBuilderValidators.email(errorText: 'E-mail inválido'),
                ]),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _carregando ? null : _enviarFormulario,
                  child:
                      _carregando
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Enviar'),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => context.pop(),
                child: const Text('Voltar para o login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
