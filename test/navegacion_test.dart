import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:boost_up/main.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('la bienvenida muestra mensaje y dos botones', (tester) async {
    await tester.pumpWidget(const BoostUpApp());

    expect(find.text('¡Hola, superhéroe del código!'), findsOneWidget);
    expect(find.text('Lista de tareas'), findsOneWidget);
    expect(find.text('Inspiración diaria'), findsOneWidget);
  });

  testWidgets('navega a la lista y vuelve', (tester) async {
    await tester.pumpWidget(const BoostUpApp());

    await tester.tap(find.text('Lista de tareas'));
    await tester.pumpAndSettle();
    expect(find.text('Mis misiones'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Lista de tareas'), findsOneWidget);
  });

  testWidgets('navega a la inspiración y vuelve', (tester) async {
    await tester.pumpWidget(const BoostUpApp());

    await tester.tap(find.text('Inspiración diaria'));
    await tester.pumpAndSettle();
    expect(find.text('Otra frase'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Inspiración diaria'), findsOneWidget);
  });
}