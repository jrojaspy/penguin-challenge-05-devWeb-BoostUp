import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:boost_up/models/tarea.dart';
import 'package:boost_up/services/almacenamiento_tareas.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('sin datos guardados devuelve lista vacía', () async {
    expect(await AlmacenamientoTareas().cargar(), isEmpty);
  });

  test('guardar y cargar devuelve las mismas tareas', () async {
    final almacen = AlmacenamientoTareas();
    await almacen.guardar([
      Tarea(id: '1', titulo: 'Leer', descripcion: 'Dos capítulos'),
      Tarea(id: '2', titulo: 'Correr', completada: true),
    ]);

    final cargadas = await almacen.cargar();

    expect(cargadas.length, 2);
    expect(cargadas[0].titulo, 'Leer');
    expect(cargadas[0].descripcion, 'Dos capítulos');
    expect(cargadas[1].completada, true);
  });

  test('una tarea eliminada no reaparece', () async {
    final almacen = AlmacenamientoTareas();
    final tareas = [Tarea(id: '1', titulo: 'A'), Tarea(id: '2', titulo: 'B')];
    await almacen.guardar(tareas);

    tareas.removeAt(0);
    await almacen.guardar(tareas);

    final cargadas = await almacen.cargar();
    expect(cargadas.length, 1);
    expect(cargadas.first.titulo, 'B');
  });

  test('datos corruptos devuelven lista vacía sin fallar', () async {
    SharedPreferences.setMockInitialValues({'tareas_v1': 'esto no es json'});
    expect(await AlmacenamientoTareas().cargar(), isEmpty);
  });
}