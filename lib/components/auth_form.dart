// ignore_for_file: constant_identifier_names, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:project_state_store/exceptions/auth_exception.dart';
import 'package:project_state_store/models/auth.dart';
import 'package:provider/provider.dart';

enum AuthMode { Signup, Login }

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  AuthMode _authMode = AuthMode.Login;

  Map<String, String> _authData = {'email': '', 'password': ''};

  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  void _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    _formKey.currentState?.save();

    Auth auth = Provider.of(context, listen: false);

    try {
      if (isLogin()) {
        await auth.signInWithPassword(
            _authData['email']!, _authData['password']!);
      } else {
        await auth.signUp(_authData['email']!, _authData['password']!);
      }
    } on AuthException catch (authError) {
      _showErrorDialog(authError.toString());
    } catch (error) {
      _showErrorDialog('Ocorreu um erro inesperado');
    }
    setState(() {
      isLoading = false;
    });
  }

  bool isLogin() => _authMode == AuthMode.Login;
  bool isSignup() => _authMode == AuthMode.Signup;

  void _switchAuthMode() {
    setState(() {
      if (isLogin()) {
        _authMode = AuthMode.Signup;
        return;
      }

      if (isSignup()) {
        _authMode = AuthMode.Login;
        return;
      }
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text('Ocorreu um erro'),
              content: Text(message),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Fechar'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
          padding: const EdgeInsets.all(16),
          height: isLogin() ? 310 : 400,
          width: deviceSize.width * 0.75,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (email) => _authData['email'] = email ?? '',
                  validator: (emailTyped) {
                    final email = emailTyped ?? '';

                    if (email.trim().isEmpty || !email.contains('@')) {
                      return 'Digite um email válido';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Senha'),
                  keyboardType: TextInputType.emailAddress,
                  obscureText: true,
                  onSaved: (password) => _authData['password'] = password ?? '',
                  controller: _passwordController,
                  validator: (passwordTyped) {
                    final password = passwordTyped ?? '';

                    if (password.isEmpty || password.length < 5) {
                      return 'Digite uma senha válida';
                    }

                    return null;
                  },
                ),
                if (isSignup())
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Confirmar senha'),
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                    validator: isLogin()
                        ? null
                        : (passwordConfirmation) {
                            final password = passwordConfirmation ?? '';

                            if (password != _passwordController.text) {
                              return 'Senhas divergentes';
                            }

                            return null;
                          },
                  ),
                const SizedBox(height: 20),
                isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 8)),
                        onPressed: _submitForm,
                        child: Text(isLogin() ? 'ENTRAR' : 'REGISTRAR')),
                const Spacer(),
                TextButton(
                    onPressed: () => _switchAuthMode(),
                    child: Text(
                        isLogin() ? 'DESEJA REGISTRAR?' : 'JÁ POSSUI CONTA?'))
              ],
            ),
          )),
    );
  }
}
