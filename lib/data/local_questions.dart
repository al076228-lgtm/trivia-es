import '../models/question.dart';

// Preguntas locales: funcionan incluso sin Internet.
// Para agregar una categoría nueva, solo agrega otra entrada al mapa
// (y su número en ApiService.categoryIds si quieres usar la API).
const localQuestions = <String, List<Question>>{
  'Cultura general': [
    Question('¿Cuál es la capital de México?', ['Monterrey', 'Ciudad de México', 'Puebla', 'Mérida'], 1),
    Question('¿Cuántos días tiene una semana?', ['5', '6', '7', '8'], 2),
    Question('¿Cuál es el océano más grande?', ['Atlántico', 'Índico', 'Pacífico', 'Ártico'], 2),
    Question('¿Qué idioma se habla principalmente en Brasil?', ['Español', 'Portugués', 'Inglés', 'Francés'], 1),
    Question('¿Cuántos lados tiene un triángulo?', ['3', '4', '5', '6'], 0),
  ],
  'Ciencia': [
    Question('¿Cuál es el planeta rojo?', ['Venus', 'Marte', 'Júpiter', 'Mercurio'], 1),
    Question('¿Qué gas necesitamos para respirar?', ['Helio', 'Oxígeno', 'Hidrógeno', 'Neón'], 1),
    Question('¿Cuántos planetas hay en el sistema solar?', ['7', '8', '9', '10'], 1),
    Question('¿Qué órgano bombea la sangre?', ['Pulmón', 'Hígado', 'Corazón', 'Riñón'], 2),
    Question('¿Qué estrella ilumina la Tierra?', ['Sirio', 'Sol', 'Polar', 'Vega'], 1),
  ],
  'Tecnología': [
    Question('¿Qué significa CPU?', ['Unidad Central de Procesamiento', 'Control Principal Universal', 'Código de Programa Único', 'Centro de Pantalla'], 0),
    Question('¿Cuál de estos es un sistema operativo?', ['HTML', 'Linux', 'CSS', 'SQL'], 1),
    Question('¿Qué lenguaje utiliza Flutter?', ['Java', 'Dart', 'PHP', 'C'], 1),
    Question('¿Qué significa HTTP?', ['HyperText Transfer Protocol', 'High Tech Text Program', 'Home Tool Transfer Process', 'Hyper Terminal Test Page'], 0),
    Question('¿Qué almacena información de forma permanente?', ['RAM', 'Caché', 'SSD', 'Registro CPU'], 2),
  ],
};
