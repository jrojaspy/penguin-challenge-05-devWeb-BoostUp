import 'dart:math';

class FrasesService {
  static const List<String> frases = [
    'Un paso pequeño hoy vale más que un plan perfecto mañana.',
    'No necesitas ver toda la escalera, solo dar el primer peldaño.',
    'Lo que haces cada día pesa más que lo que haces de vez en cuando.',
    'Empezar imperfecto supera esperar a estar listo.',
    'La disciplina es recordar lo que realmente quieres.',
    'Termina una tarea pequeña y deja que el impulso haga el resto.',
    'Cada misión cumplida es un voto por la persona que quieres ser.',
    'Hoy es un buen día para tachar algo de tu lista.',
    'El cansancio pasa; la satisfacción de haber cumplido se queda.',
    'Divide la montaña en tareas y camina una a la vez.',
  ];

final Random _azar = Random(); // generador de numeros aleatorios
String? _ultima; // nullable

String siguiente() {
  String elegida;
  do { // do-while  garantiza que no se repita la frase anterior, si hay más de una frase
    elegida = frases[_azar.nextInt(frases.length)];
  } while (elegida == _ultima && frases.length > 1);
  _ultima = elegida;
  return elegida;
  }
}