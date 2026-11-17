import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:boost_up/screens/inspiracion_screen.dart';
import 'package:boost_up/services/frases_service.dart';

void main() {
  test('hay al menos dos frases disponibles', () {
    expect(FrasesService.frases.length, greaterThanOrEqualTo(2));
  });

  test('nunca repite la misma frase dos veces seguidas', () {
    final servicio = FrasesService();
    var anterior = servicio.siguiente();

    for (var i = 0; i < 100; i++) {
      final actual = servicio.siguiente();
      expect(actual, isNot(anterior));
      anterior = actual;
    }
  });

  testWidgets('la pantalla muestra una frase y el botón la cambia',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(home: PantallaInspiracion()));

    String frase() => tester.widget<Text>(find.byKey(const Key('frase'))).data!;

    final antes = frase();
    expect(FrasesService.frases, contains(antes));

    await tester.tap(find.text('Otra frase'));
    await tester.pump();

    expect(frase(), isNot(antes));
    expect(FrasesService.frases, contains(frase()));
  });
}