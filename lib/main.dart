import 'package:material_ui/material_ui.dart'; // componentes visuales
import '../screens/bienvenida_screen.dart'; // pantalla de bienvenida

void main() { // punto de entrada 
  runApp(const BoostUpApp()); 
}

class BoostUpApp extends StatelessWidget {
  const BoostUpApp({super.key}); 

  @override 
  Widget build(BuildContext context) { // define una interfaz
    return MaterialApp( // contenedor de alto nivel
      title: 'Boost Up', 
      debugShowCheckedModeBanner: false,
      theme: ThemeData( 
        colorSchemeSeed: Colors.deepPurple, 
        useMaterial3: true, 
      ),
      home: const PantallaBienvenida(), // ruta de inicio
    );
  }
}