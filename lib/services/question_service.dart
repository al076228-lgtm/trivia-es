import '../data/local_questions.dart';
import '../models/question.dart';
import 'api_service.dart';

// Decide de dónde salen las preguntas: de Internet o locales.
class QuestionService {
  final ApiService _api = ApiService();

  // Para saber si las preguntas realmente vinieron de la API.
  bool usedApi = false;

  Future<List<Question>> loadQuestions(String category, bool useInternet) async {
    usedApi = false;

    if (useInternet) {
      final fromApi = await _api.fetchQuestions(category);
      if (fromApi != null && fromApi.isNotEmpty) {
        usedApi = true;
        return fromApi;
      }
    }

    // Plan B: preguntas locales.
    return List<Question>.from(localQuestions[category]!);
  }
}
