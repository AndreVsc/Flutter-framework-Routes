# 📱 Flutter Framework: Routes

Este projeto demonstra a implementação de um sistema de login com navegação entre telas usando o framework Flutter. Ele inclui:

- Uma tela de login com validação de credenciais.
- Navegação para uma tela inicial após o login bem-sucedido.
- Uso de rotas e callbacks para gerenciar o estado do login.

---

## 🗂️ Estrutura do Projeto

### 1️⃣ **Classe `Login`**
Responsável por validar as credenciais do usuário.

#### Código:
```dart
class Login {
  final String username;
  final String password;

  Login({required this.username, required this.password});

  bool isValid() {
    return username == "admin" && password == "1234";
  }
}
```

#### Explicação:
- **`username` e `password`**: Armazenam as credenciais do usuário.
- **`isValid()`**: Verifica se as credenciais fornecidas correspondem ao usuário `"admin"` e à senha `"1234"`.

---

### 2️⃣ **Tela `HomeScreen`**
Exibe uma mensagem de sucesso após o login.

#### Código:
```dart
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.amber,
      ),
      body: const Center(
        child: Text('Login realizado com sucesso!'),
      ),
    );
  }
}
```

#### Explicação:
- **`Scaffold`**: Estrutura básica da tela com `AppBar` e `body`.
- **`AppBar`**: Barra superior com título e cor de fundo personalizada.
- **`Center`**: Centraliza o texto no meio da tela.

---

### 3️⃣ **Tela `LoginScreen`**
Contém a interface de login com uma imagem no topo e um formulário.

#### Código:
```dart
import 'package:flutter/material.dart';
import '../widgets/login_form.dart';
import '../screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Imagem no topo
            Image.asset(
              'assets/logo.jpg',
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            // Formulário de login
            Padding(
              padding: const EdgeInsets.all(20),
              child: LoginForm(
                onLoginSuccess: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                },
                onLoginFailed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Falha no login. Verifique suas credenciais.',
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

#### Explicação:
- **`Image.asset`**: Renderiza a imagem no topo da tela.
- **`LoginForm`**: Widget que contém os campos de entrada e lógica de validação.
- **`Navigator.pushReplacement`**: Navega para a `HomeScreen` após o login bem-sucedido.
- **`SnackBar`**: Exibe uma mensagem de erro em caso de falha no login.

---

### 4️⃣ **Widget `LoginForm`**
Contém os campos de entrada e a lógica de validação do login.

#### Código:
```dart
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
      password: _usernameController.text,
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
            labelText: 'Email',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
        const SizedBox(height: 16),

        // Campo de senha
        TextField(
          controller: _passwordController,
          decoration: const InputDecoration(
            labelText: 'Password',
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
```

#### Explicação:
- **`TextField`**: Campos de entrada para email e senha.
- **`ElevatedButton`**: Botão de login com estilo personalizado.
- **`onLoginSuccess` e `onLoginFailed`**: Callbacks para gerenciar o resultado do login.

---

### 5️⃣ **Classe `MyApp`**
Configura o aplicativo e define a tela inicial.

#### Código:
```dart
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginScreen(),
    );
  }
}
```

#### Explicação:
- **`MaterialApp`**: Define o tema e a tela inicial do aplicativo.
- **`LoginScreen`**: Tela inicial do aplicativo.

---

## 📄 Licença
Este projeto está sob a **MIT License** – sinta-se livre para usar e modificar.