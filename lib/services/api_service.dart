import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/question.dart';
import '../utils/html_decoder.dart';

class ApiService {
  static const categoryIds = {
    'Cultura general': 9,
    'Ciencia': 17,
    'Tecnología': 18,
  };

  // Traduce textos de inglés a español.
  Future<String?> translate(String text) async {
    try {
      final url = Uri.https(
        'api.mymemory.translated.net',
        '/get',
        {
          'q': text,
          'langpair': 'en|es',
        },
      );

      final response = await http.get(url).timeout(
            const Duration(seconds: 10),
          );

      if (response.statusCode != 200) return null;

      final data = jsonDecode(response.body);

      if (data['responseStatus'] != 200) return null;

      final translated = decodeHtml(
        data['responseData']['translatedText'] as String,
      ).trim();

      if (translated.isEmpty ||
          translated.toUpperCase().contains('MYMEMORY WARNING')) {
        return null;
      }

      // Si una oración en inglés sigue igual,
      // consideramos que no se tradujo correctamente.
      if (translated.toLowerCase() == text.trim().toLowerCase() &&
          RegExp(
            r'\b(the|which|what|where|when|who|does|is|are|was|were|would|could)\b',
            caseSensitive: false,
          ).hasMatch(text)) {
        return null;
      }

      return translated;
    } catch (_) {
      return null;
    }
  }

  // Obtiene cinco preguntas de la API.
  Future<List<Question>?> fetchQuestions(String category) async {
    try {
      final categoryId = categoryIds[category];

      if (categoryId == null) return null;

      final url = Uri.https(
        'opentdb.com',
        '/api.php',
        {
          'amount': '5',
          'category': '$categoryId',
          'difficulty': 'easy',
          'type': 'multiple',
        },
      );

      final response = await http.get(url).timeout(
            const Duration(seconds: 10),
          );

      if (response.statusCode != 200) return null;

      final data = jsonDecode(response.body);

      if (data['response_code'] != 0) return null;

      final questions = <Question>[];

      for (final item in data['results'] as List) {
        final originalQuestion = decodeHtml(
          item['question'] as String,
        );

        final correct = decodeHtml(
          item['correct_answer'] as String,
        );

        final wrong = (item['incorrect_answers'] as List)
            .map((answer) => decodeHtml(answer as String))
            .toList();

        // Traducimos el enunciado y las cuatro respuestas.
        final translated = await Future.wait([
          translate(originalQuestion),
          translate(correct),
          ...wrong.map(translate),
        ]);

        // Si alguna traducción falla, usamos respaldo local.
        if (translated.any((text) => text == null)) {
          return null;
        }

        final questionText = translated[0]!;

        final options = translated.skip(1).map((text) => text!).toList();

        // La primera opción era la correcta antes de mezclar.
        final correctAnswer = options.first;

        options.shuffle();

        questions.add(
          Question(
            questionText,
            options,
            options.indexOf(correctAnswer),
          ),
        );
      }

      return questions;
    } catch (_) {
      return null;
    }
  }
}
