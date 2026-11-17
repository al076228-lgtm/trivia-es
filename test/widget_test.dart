import 'package:flutter_test/flutter_test.dart';
import 'package:trivia_quiz/data/local_questions.dart';
import 'package:trivia_quiz/utils/html_decoder.dart';

void main() {
  test('decodeHtml convierte entidades HTML', () {
    expect(decodeHtml('&quot;Hola&quot; &amp; adi&oacute;s'), '"Hola" & adiós');
  });

  test('cada categoría tiene 5 preguntas válidas', () {
    localQuestions.forEach((category, questions) {
      expect(questions.length, 5, reason: category);
      for (final q in questions) {
        expect(q.correct >= 0 && q.correct < q.answers.length, true);
      }
    });
  });
}
