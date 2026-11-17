import 'package:material_ui/material_ui.dart';
import '../models/tarea.dart';

class PantallaDetalleTarea extends StatelessWidget { // widget sin estado interno mutable, solo dibuija datos que recibe
  final Tarea tarea;

  const PantallaDetalleTarea({super.key, required this.tarea});

  @override
  Widget build(BuildContext context) {
    return Scaffold( // esqueleto de la pantalla (barra superior y cuerpo)
      appBar: AppBar(title: const Text('Detalle de la misión')), // crea la barra superior con el título
      body: Padding( // agrega un espacio alrededor del contenido
        padding: const EdgeInsets.all(20),
        child: Column( // organiza los elementos en una columna vertical
          crossAxisAlignment: CrossAxisAlignment.start, // alinea los elementos al inicio del eje horizontal
          children: [
            Text(
              tarea.titulo,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            Text(
              tarea.descripcion.isEmpty
                  ? 'Esta misión no tiene descripción.'
                  : tarea.descripcion,
            ),
            const SizedBox(height: 12),
            Chip( // componente visual que muestra un estado o categoría
              label: Text(tarea.completada ? 'Completada' : 'Pendiente'),
            ),
            const Spacer(), // widget flexible que ocupa el espacio disponible, empujando los elementos hacia arriba
            SizedBox( 
              width: double.infinity, // hace que el botón ocupe todo el ancho disponible
              child: FilledButton.icon( // botón con icono y texto
                icon: const Icon(Icons.check),
                label: Text(
                  tarea.completada
                      ? 'Marcar como pendiente'
                      : 'Marcar como completada',
                ),
                onPressed: () => Navigator.pop(context, true), // cierra la pantalla y devuelve un valor booleano indicando que se ha cambiado el estado de la tarea
              ),
            ),
          ],
        ),
      ),
    );
  }
}