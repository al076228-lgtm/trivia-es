import 'package:flutter/material.dart';

// Botón de una opción de respuesta. Recibe el color de fondo
// (verde / rojo / ninguno) desde la pantalla del juego.
class AnswerButton extends StatelessWidget {
  final String text;
  final Color? color;
  final VoidCallback onPressed;

  const AnswerButton({
    super.key,
    required this.text,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.all(16),
            backgroundColor: color,
          ),
          onPressed: onPressed,
          child: Text(text, textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
