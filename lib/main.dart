import 'package:material_ui/material_ui.dart'; // componentes visuales
import '../screens/bienvenida_screen.dart'; // pantalla de bienvenida

void main() { // funcion principal
  runApp(const BoostUpApp()); // toma el widget raiz para renderizarlo
}

class BoostUpApp extends StatelessWidget { // widget sin estado interno mutable (widget padre) ideal para la configuracion base de una app
  const BoostUpApp({super.key}); // constructor de clase

  @override // sobreescribir una implementacion previa definida en su clase padre o en una interfaz
  Widget build(BuildContext context) { // describe como debe dibujarse este widget
    return MaterialApp( // 
      title: 'Boost Up', // nombre de la app
      debugShowCheckedModeBanner: false,
      theme: ThemeData( // configura el estilo visual global
        colorSchemeSeed: Colors.deepPurple, // genera la paleta completa y armonica de colores
        useMaterial3: true, // version mas moderna de material design
      ),
      home: const PantallaBienvenida(), // define la ruta inicial o pantalla de arranque de la aplicacion
    );
  }
}