import 'package:flutter/material.dart';
import '../models/question.dart';
import '../services/question_service.dart';
import '../widgets/answer_button.dart';
import 'result_screen.dart';

// Pantalla 3: Juego (el widget con más estado de la app)
class QuizScreen extends StatefulWidget {
  final String category;
  final bool useInternet;

  const QuizScreen({
    super.key,
    required this.category,
    required this.useInternet,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final QuestionService _service = QuestionService();

  List<Question> questions = [];
  bool loading = true;
  bool fromApi = false;
  int index = 0; // pregunta actual
  int score = 0; // puntos
  int? selected; // respuesta elegida (null = aún no responde)

  @override
  void initState() {
    super.initState();
    startQuiz();
  }

  Future<void> startQuiz() async {
    final loaded =
        await _service.loadQuestions(widget.category, widget.useInternet);
    if (!mounted) return;
    setState(() {
      questions = loaded;
      fromApi = _service.usedApi;
      loading = false;
    });
  }

  void selectAnswer(int answer) {
    if (selected != null) return; // ya respondió esta pregunta
    setState(() {
      selected = answer;
      if (answer == questions[index].correct) score++;
    });
  }

  void nextQuestion() {
    if (index + 1 == questions.length) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultScreen(
            category: widget.category,
            score: score,
            total: questions.length,
          ),
        ),
      );
    } else {
      setState(() {
        index++;
        selected = null;
      });
    }
  }

  // Color del botón según la respuesta
  Color? answerColor(int i) {
    if (selected == null) return null;
    if (i == questions[index].correct) return Colors.green.shade100;
    if (i == selected) return Colors.red.shade100;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category)),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 650),
          child: loading ? const CircularProgressIndicator() : buildQuestion(),
        ),
      ),
    );
  }

  Widget buildQuestion() {
    final question = questions[index];

    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text('Pregunta ${index + 1} de ${questions.length}    •    Puntos: $score'),
        const SizedBox(height: 4),
        Text(
          fromApi ? 'Fuente: Internet (API)' : 'Fuente: preguntas locales',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 12),
        LinearProgressIndicator(value: (index + 1) / questions.length),
        const SizedBox(height: 30),
        Text(question.text, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 22),
        for (var i = 0; i < question.answers.length; i++)
          AnswerButton(
            text: question.answers[i],
            color: answerColor(i),
            onPressed: () => selectAnswer(i),
          ),
        if (selected != null) ...[
          const SizedBox(height: 14),
          Text(
            selected == question.correct ? '¡Correcto!' : 'Respuesta incorrecta',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: nextQuestion,
            child: Text(index + 1 == questions.length
                ? 'Ver resultados'
                : 'Siguiente pregunta'),
          ),
        ],
      ],
    );
  }
}
