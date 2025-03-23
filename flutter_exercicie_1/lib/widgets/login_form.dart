import 'package:flutter/material.dart';
import '../models/login.dart';

class LoginForm extends StatefulWidget {
  final Function onLoginSuccess;
  final Function onLoginFailed;

  const LoginForm({
    super.key,
    required this.onLoginSuccess,
    required this.onLoginFailed,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    final login = Login(
      username: _usernameController.text,
      password: _passwordController.text,
    );

    if (login.isValid()) {
      widget.onLoginSuccess();
    } else {
      widget.onLoginFailed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Campo de email
        TextField(
          controller: _usernameController,
          decoration: const InputDecoration(
            labelText: 'email',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
        const SizedBox(height: 16),

        // Campo de senha
        TextField(
          controller: _passwordController,
          decoration: const InputDecoration(
            labelText: 'password',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 8),

        // Link "Esqueceu a senha?"
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: const Text(
              'Forgot password?',
              style: TextStyle(color: Colors.amber),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Botão de login
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _handleLogin,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Login', style: TextStyle(color: Colors.white)),
          ),
        ),
        const SizedBox(height: 16),

        // Texto "Novo aqui? Crie uma conta"
        TextButton(
          onPressed: () {},
          child: const Text(
            'New user? Create account',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
