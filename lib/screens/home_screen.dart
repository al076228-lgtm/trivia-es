import 'package:flutter/material.dart';
import '../config/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Scaffold(
      appBar: AppBar(title: const Text('Trivia Quiz')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.quiz, size: 100, color: color),
                const SizedBox(height: 18),
                Text('¡Pon a prueba tus conocimientos!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 12),
                const Text('Responde 5 preguntas y descubre tu puntuación.',
                    textAlign: TextAlign.center),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () => Navigator.pushNamed(context, AppRoutes.categories),
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Jugar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
