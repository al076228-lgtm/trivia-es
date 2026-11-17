# Trivia Quiz (Flutter) — versión sencilla, sin base de datos

Proyecto modular de 4 pantallas: Inicio, Categorías, Juego y Resultados.

## Características
- 4 pantallas navegables mediante Navigator.
- StatefulWidget en Categorías (interruptor de Internet) y Juego (pregunta, puntos y respuesta).
- Consumo HTTP de Open Trivia Database (`https://opentdb.com/api.php`) mediante el paquete `http`.
- Si la API falla o se desactiva Internet, se utilizan las 5 preguntas locales de cada categoría.
- Las preguntas de OpenTDB se traducen al español con la API HTTP de MyMemory. Si alguna consulta o traducción falla, se usan preguntas locales en español. El servicio gratuito de traducción puede tener límites de uso.
- No usa SQLite, base de datos, archivos de historial ni almacenamiento persistente.
- Los resultados solo se muestran en pantalla al terminar.

## Ejecutar en Debian/Linux
Desde la carpeta `trivia_quiz`:

```bash
flutter create --platforms=android,linux .
flutter pub get
flutter run -d linux
```

## Ejecutar en Android
Con el SDK y un teléfono configurados:

```bash
flutter devices
flutter run -d ID_DEL_DISPOSITIVO
```

Para permitir solicitudes de Internet en una compilación Android de producción, agrega esta línea en `android/app/src/main/AndroidManifest.xml` antes de `<application>`:

```xml
<uses-permission android:name="android.permission.INTERNET" />
```

Luego puedes ejecutar `flutter build apk --release`.

## Estructura sencilla
- `lib/main.dart`: inicia la aplicación.
- `lib/app.dart`: tema y rutas de inicio/categorías.
- `lib/config/routes.dart`: nombres de rutas.
- `lib/screens/`: 4 pantallas.
- `lib/models/question.dart`: estructura de una pregunta.
- `lib/data/local_questions.dart`: preguntas sin Internet.
- `lib/services/api_service.dart`: consulta OpenTDB, traduce con MyMemory y lee JSON.
- `lib/services/question_service.dart`: elige preguntas API o locales.
- `lib/widgets/answer_button.dart`: botón reutilizable.
- `lib/utils/html_decoder.dart`: convierte caracteres HTML de la API.

## Demostración
1. Inicia una partida sin Internet para mostrar preguntas locales.
2. Activa «Preguntas desde Internet» para mostrar preguntas de la API.
3. Responde y observa cómo cambian los puntos y el progreso.
4. Termina y vuelve al inicio.

Nota: Flutter no se encuentra instalado en el entorno donde se preparó este ZIP; no se pudo realizar una compilación real. El código debe probarse en Linux y Android antes de la entrega.
