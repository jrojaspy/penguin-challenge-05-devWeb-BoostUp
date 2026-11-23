import 'package:material_ui/material_ui.dart';
import '../models/tarea.dart';
import '../services/almacenamiento_tareas.dart';
import 'detalle_tarea_screen.dart';

class PantallaListaTareas extends StatefulWidget {
  const PantallaListaTareas({super.key});

  @override
  State<PantallaListaTareas> createState() => _PantallaListaTareasState();
}

class _PantallaListaTareasState extends State<PantallaListaTareas> {
  final _almacen = AlmacenamientoTareas();
  List<Tarea> _tareas = [];
  bool _cargando = true;

  @override
  void initState() {
    super.initState();
    _cargar();
  }

  Future<void> _cargar() async {
    final guardadas = await _almacen.cargar();
    if (!mounted) return;
    setState(() {
      _tareas = guardadas;
      _cargando = false;
    });
  }

  Future<void> _guardar() async {
    await _almacen.guardar(_tareas);
  }

  Future<void> _agregar(String titulo, String descripcion) async {
    setState(() {
      _tareas.add(Tarea(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        titulo: titulo,
        descripcion: descripcion,
      ));
    });
    await _guardar();
  }

  Future<void> _eliminar(Tarea tarea) async {
    setState(() => _tareas.removeWhere((t) => t.id == tarea.id));
    await _guardar();
  }

  Future<void> _alternarCompletada(Tarea tarea) async {
    setState(() => tarea.completada = !tarea.completada);
    await _guardar();
  }

  Future<void> _abrirDetalle(Tarea tarea) async {
    final cambio = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => PantallaDetalleTarea(tarea: tarea),
      ),
    );

    if (cambio == true) {
      await _alternarCompletada(tarea);
    }
  }

  Future<void> _mostrarDialogoAlta() async {
    final datos = await showDialog<List<String>>(
      context: context,
      builder: (_) => const _DialogoNuevaTarea(),
    );

    if (datos != null) {
      await _agregar(datos[0], datos[1]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tareasOrdenadas = [..._tareas]
      ..sort(
        (a, b) => (a.completada ? 1 : 0).compareTo(b.completada ? 1 : 0),
      );

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Mis misiones'),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${_tareas.length}',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
      ),
      body: _cargando
          ? const Center(child: CircularProgressIndicator())
          : tareasOrdenadas.isEmpty
              ? const Center(
                  child: Text('Sin misiones. ¡Agrega la primera!'),
                )
              : ListView.builder(
                  itemCount: tareasOrdenadas.length,
                  itemBuilder: (context, indice) {
                    final tarea = tareasOrdenadas[indice];
                    return Card(
                      child: ListTile(
                        leading: Checkbox(
                          value: tarea.completada,
                          onChanged: (_) => _alternarCompletada(tarea),
                        ),
                        title: Text(
                          tarea.titulo,
                          style: TextStyle(
                            decoration: tarea.completada
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        subtitle: tarea.descripcion.isEmpty
                            ? null
                            : Text(tarea.descripcion),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline),
                          tooltip: 'Eliminar',
                          onPressed: () => _eliminar(tarea),
                        ),
                        onTap: () => _abrirDetalle(tarea),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarDialogoAlta,
        tooltip: 'Agregar misión',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _DialogoNuevaTarea extends StatefulWidget {
  const _DialogoNuevaTarea();

  @override
  State<_DialogoNuevaTarea> createState() => _DialogoNuevaTareaState();
}

class _DialogoNuevaTareaState extends State<_DialogoNuevaTarea> {
  final _titulo = TextEditingController();
  final _descripcion = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _titulo.dispose();
    _descripcion.dispose();
    super.dispose();
  }

  void _confirmar() {
    final titulo = _titulo.text.trim();
    if (titulo.isEmpty) {
      setState(() => _error = 'Escribe un título');
      return;
    }
    Navigator.pop(context, [titulo, _descripcion.text.trim()]);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nueva misión'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titulo,
            autofocus: true,
            decoration: InputDecoration(
              labelText: 'Título',
              errorText: _error,
            ),
          ),
          TextField(
            controller: _descripcion,
            decoration: const InputDecoration(labelText: 'Descripción'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: _confirmar,
          child: const Text('Agregar'),
        ),
      ],
    );
  }
}