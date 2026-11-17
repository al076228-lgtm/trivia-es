// La API devuelve texto con entidades HTML (por ejemplo &quot;).
// Esta función las convierte en caracteres normales.
String decodeHtml(String text) {
  var value = text;

  const entities = {
    '&quot;': '"',
    '&#039;': "'",
    '&#39;': "'",
    '&lt;': '<',
    '&gt;': '>',
    '&eacute;': 'é',
    '&aacute;': 'á',
    '&iacute;': 'í',
    '&oacute;': 'ó',
    '&uacute;': 'ú',
    '&ntilde;': 'ñ',
    '&ldquo;': '“',
    '&rdquo;': '”',
    '&rsquo;': '’',
    '&hellip;': '…',
    '&amp;': '&', // siempre al final para no decodificar dos veces
  };

  entities.forEach((key, replacement) {
    value = value.replaceAll(key, replacement);
  });

  // Códigos numéricos como &#233;
  value = value.replaceAllMapped(RegExp(r'&#(\d+);'), (match) {
    final code = int.tryParse(match.group(1)!);
    return code == null ? match.group(0)! : String.fromCharCode(code);
  });

  return value;
}
