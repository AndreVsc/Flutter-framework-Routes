import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home'), backgroundColor: Colors.amber),
      body: const Center(child: Text('Login realizado com sucesso!')),
    );
  }
}
