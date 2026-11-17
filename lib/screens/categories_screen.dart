import 'package:flutter/material.dart';
import '../data/local_questions.dart';
import 'quiz_screen.dart';

// Pantalla 2: Categorías (con estado por el interruptor de Internet)
class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  bool useInternet = false;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(title: const Text('Elige una categoría')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              SwitchListTile(
                title: const Text('Preguntas desde Internet'),
                subtitle: const Text(
                    'Preguntas traducidas al español. Si falla Internet, se usan preguntas locales.'),
                value: useInternet,
                onChanged: (value) => setState(() => useInternet = value),
              ),
              const SizedBox(height: 12),
              for (final category in localQuestions.keys)
                Card(
                  child: ListTile(
                    leading: Icon(Icons.category, color: color),
                    title: Text(category),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => QuizScreen(
                          category: category,
                          useInternet: useInternet,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
