import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/question.dart';
import '../utils/html_decoder.dart';

// Obtiene preguntas de OpenTDB y las traduce al español con MyMemory.
// Si falla cualquier petición, se usarán las preguntas locales.
class ApiService {
  static const categoryIds = {
    'Cultura general': 9,
    'Ciencia': 17,
    'Tecnología': 18,
  };

  Future<String?> translate(String text) async {
    try {
      final url = Uri.https('api.mymemory.translated.net', '/get', {
        'q': text,
        'langpair': 'en|es',
      });
      final response = await http.get(url).timeout(const Duration(seconds: 8));
      if (response.statusCode != 200) return null;
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      if (data['responseStatus'] != 200) return null;
      final translated = decodeHtml(data['responseData']['translatedText'] as String);
      if (translated.trim().isEmpty || translated.contains('MYMEMORY WARNING')) {
        return null;
      }
      return translated;
    } catch (_) {
      return null;
    }
  }

  Future<List<Question>?> fetchQuestions(String category) async {
    try {
      final url = Uri.https('opentdb.com', '/api.php', {
        'amount': '5',
        'type': 'multiple',
        'category': '${categoryIds[category]}',
      });
      final response = await http.get(url).timeout(const Duration(seconds: 8));
      if (response.statusCode != 200) return null;
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      if (data['response_code'] != 0) return null;

      final questions = <Question>[];
      for (final item in data['results'] as List) {
        final originalQuestion = decodeHtml(item['question'] as String);
        final correct = decodeHtml(item['correct_answer'] as String);
        final wrong = (item['incorrect_answers'] as List)
            .map((answer) => decodeHtml(answer as String))
            .toList();

        // Traducción de pregunta y cuatro opciones.
        final translated = await Future.wait([
          translate(originalQuestion),
          translate(correct),
          ...wrong.map(translate),
        ]);
        if (translated.any((value) => value == null)) return null;

        final options = translated.skip(1).cast<String>().toList();
        final correctAnswer = options.first;
        options.shuffle();
        questions.add(Question(translated.first!, options, options.indexOf(correctAnswer)));
      }
      return questions;
    } catch (_) {
      return null;
    }
  }
}
