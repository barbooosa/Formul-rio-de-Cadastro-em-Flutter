import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          // 1. Container Principal da estrutura
          child: AtividadeContainerColumn(),
        ),
      ),
    );
  }
}

class AtividadeContainerColumn extends StatelessWidget {
  const AtividadeContainerColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Cor de fundo do Container Principal
      color: Colors.blueGrey[100],
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(20.0),
      // Column como child do Container Principal
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 🔹 PARTE 1: Container do Ícone (Icon)
          Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.amber[300],
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: const Column(
              children: [
                Icon(
                  Icons.flutter_dash,
                  size: 64.0,
                  color: Colors.blueAccent,
                ),
                SizedBox(height: 8.0),
                Text(
                  'Container 1: Ícone',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),

          // 🔹 PARTE 2: Container do Texto (Text)
          Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.teal[300],
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: const Text(
              'Container 2: Aprendendo Flutter!\nO Column organiza widgets verticalmente.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),

          // 🔹 PARTE 3: Container da Imagem (Image.network)
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.deepPurple[300],
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    'https://picsum.photos/400/200',
                    height: 140.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'Container 3: Imagem',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
