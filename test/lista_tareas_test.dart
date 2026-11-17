import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:boost_up/screens/lista_tareas_screen.dart';

Future<void> agregarTarea(WidgetTester tester, String titulo) async {
  await tester.tap(find.byType(FloatingActionButton));
  await tester.pumpAndSettle();
  await tester.enterText(find.byType(TextField).first, titulo);
  await tester.tap(find.text('Agregar'));
  await tester.pumpAndSettle();
}

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('muestra mensaje cuando no hay tareas', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: PantallaListaTareas()));
    await tester.pumpAndSettle();

    expect(find.text('Sin misiones. ¡Agrega la primera!'), findsOneWidget);
  });

  testWidgets('agrega una tarea con el botón flotante', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: PantallaListaTareas()));
    await tester.pumpAndSettle();

    await agregarTarea(tester, 'Estudiar Flutter');

    expect(find.text('Estudiar Flutter'), findsOneWidget);
    expect(find.text('Sin misiones. ¡Agrega la primera!'), findsNothing);
  });

  testWidgets('no permite agregar una tarea sin título', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: PantallaListaTareas()));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Agregar'));
    await tester.pumpAndSettle();

    expect(find.text('Escribe un título'), findsOneWidget);
  });

  testWidgets('elimina una tarea con la papelera', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: PantallaListaTareas()));
    await tester.pumpAndSettle();

    await agregarTarea(tester, 'Hacer ejercicio');
    expect(find.text('Hacer ejercicio'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.delete_outline));
    await tester.pumpAndSettle();

    expect(find.text('Hacer ejercicio'), findsNothing);
  });
}