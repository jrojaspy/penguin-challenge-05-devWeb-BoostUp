import 'package:material_ui/material_ui.dart'; // importaciones
import 'inspiracion_screen.dart';
import 'lista_tareas_screen.dart';

class PantallaBienvenida extends StatelessWidget { 
  const PantallaBienvenida({super.key}); 

  @override
  Widget build(BuildContext context) {  
    final tema = Theme.of(context); 

    return Scaffold( 
      body: SafeArea( 
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                mainAxisSize: MainAxisSize.min, 
                crossAxisAlignment: CrossAxisAlignment.stretch, 
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
                    'Boost Up te ayuda a organizar tu día.',
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
                      Navigator.push( // enturamiento de flutter
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PantallaInspiracion(), // transicion de pantalla
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