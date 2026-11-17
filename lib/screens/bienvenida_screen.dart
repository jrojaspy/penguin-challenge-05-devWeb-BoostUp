import 'package:material_ui/material_ui.dart'; // importaciones
import 'inspiracion_screen.dart';
import 'lista_tareas_screen.dart';

class PantallaBienvenida extends StatelessWidget { // pantalla estática ( no necesita almacenar datos que cambien dinamicamente dentro de si misma )
  const PantallaBienvenida({super.key}); // superkey clave unica que se pasa al widget padre permitiendo a Flutter identificar y optimizaar el arbol de widgets 

  @override
  Widget build(BuildContext context) { // 
    final tema = Theme.of(context); // recupera el themedata definido previamente en main.dart

    return Scaffold( // estructura visual basica de una pantalla en MD
      body: SafeArea( // evita que el contenido quede oculto detras de elementos fisicos
        child: Center( // centra todo el contenido tanto vertical como horizontal
          child: Padding( // añade un margen interno
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox( // limita maximo a 480 pixeles
              constraints: const BoxConstraints(maxWidth: 480), // evita que los botones se estiren exageradamente
              child: Column( // apila los elementos verticalmente de arriba hacia abajo
                mainAxisSize: MainAxisSize.min, // hace que la columna ocupe solo la altura minima necesaria para sus hijos
                crossAxisAlignment: CrossAxisAlignment.stretch, // estira los hijos horizontalmente para que ocupen todo el ancho disponible
                children: [
                  Icon( 
                    Icons.rocket_launch,
                    size: 72,
                    color: tema.colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '¡Hola, superhéroe del código!',
                    textAlign: TextAlign.center,
                    style: tema.textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Boost Up te ayuda a organizar tu día y a conquistarlo.',
                    textAlign: TextAlign.center,
                    style: tema.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 32),
                  FilledButton.icon(
                    icon: const Icon(Icons.checklist),
                    label: const Text('Lista de tareas'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PantallaListaTareas(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.bolt),
                    label: const Text('Inspiración diaria'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PantallaInspiracion(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}