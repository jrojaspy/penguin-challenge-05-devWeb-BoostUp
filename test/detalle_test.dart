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

  testWidgets('tocar una tarea abre su detalle', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: PantallaListaTareas()));
    await tester.pumpAndSettle();
    await agregarTarea(tester, 'Preparar informe');

    await tester.tap(find.text('Preparar informe'));
    await tester.pumpAndSettle();

    expect(find.text('Detalle de la misión'), findsOneWidget);
    expect(find.text('Preparar informe'), findsOneWidget);
    expect(find.text('Pendiente'), findsOneWidget);
  });

  testWidgets('el detalle puede marcar la tarea como completada',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(home: PantallaListaTareas()));
    await tester.pumpAndSettle();
    await agregarTarea(tester, 'Preparar informe');

    await tester.tap(find.text('Preparar informe'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Marcar como completada'));
    await tester.pumpAndSettle();

    expect(find.text('Mis misiones'), findsOneWidget);
    final casilla = tester.widget<Checkbox>(find.byType(Checkbox));
    expect(casilla.value, true);
  });
}