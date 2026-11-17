// Una pregunta con sus opciones y el índice de la respuesta correcta.
class Question {
  final String text;
  final List<String> answers;
  final int correct;

  const Question(this.text, this.answers, this.correct);
}
