import 'package:flutter/material.dart';
import '../config/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trivia Quiz'),
      ),

      // Diseño responsivo para Windows y Android.
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 440,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.quiz,
                            size: 100,
                            color: color,
                          ),
                          const SizedBox(height: 18),
                          Text(
                            '¡Pon a prueba tus conocimientos!',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Responde 5 preguntas y descubre tu puntuación.',
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 32),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton.icon(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.categories,
                                );
                              },
                              icon: const Icon(Icons.play_arrow),
                              label: const Text('Jugar'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),

      // Pie de página responsivo.
      bottomNavigationBar: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Programación Avanzada.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Universidad Autónoma de Campeche',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(height: 5),
              Text(
                'Integrantes: Uriel Quetz, Leonardo Góngora, Aldair Canul, Aarón Chi',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Facultad de Ingeniería · 2026',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
