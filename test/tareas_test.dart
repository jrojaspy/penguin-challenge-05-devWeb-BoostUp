import 'package:flutter_test/flutter_test.dart';
import 'package:boost_up/models/tarea.dart';

void main() {
  test('Tarea sobrevive a toJson y fromJson', () {
    final original = Tarea(
      id: '1',
      titulo: 'Estudiar Dart',
      descripcion: 'Capítulo 3',
      completada: true,
    );

    final copia = Tarea.fromJson(original.toJson());

    expect(copia.id, '1');
    expect(copia.titulo, 'Estudiar Dart');
    expect(copia.descripcion, 'Capítulo 3');
    expect(copia.completada, true);
  });

  test('una tarea nueva nace pendiente y sin descripción', () {
    final t = Tarea(id: '2', titulo: 'Leer');
    expect(t.completada, false);
    expect(t.descripcion, '');
  });
}