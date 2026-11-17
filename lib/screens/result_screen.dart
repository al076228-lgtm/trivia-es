import 'package:flutter/material.dart';
import '../config/routes.dart';

// Muestra el resultado; no guarda información en ninguna base de datos.
class ResultScreen extends StatelessWidget {
  final String category;
  final int score;
  final int total;

  const ResultScreen({
    super.key,
    required this.category,
    required this.score,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resultados'), automaticallyImplyLeading: false),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.emoji_events, size: 95, color: Colors.amber),
              const SizedBox(height: 20),
              Text('¡Terminaste!', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 10),
              Text(category),
              const SizedBox(height: 15),
              Text('$score / $total', style: Theme.of(context).textTheme.displayMedium),
              const SizedBox(height: 30),
              FilledButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context, AppRoutes.home, (route) => false),
                child: const Text('Volver al inicio'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
