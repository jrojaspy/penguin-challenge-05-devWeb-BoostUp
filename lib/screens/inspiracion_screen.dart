import 'package:material_ui/material_ui.dart';
import '../services/frases_service.dart';

class PantallaInspiracion extends StatefulWidget {
  const PantallaInspiracion({super.key});

  @override
  State<PantallaInspiracion> createState() => _PantallaInspiracionState();
}

class _PantallaInspiracionState extends State<PantallaInspiracion> {
  final _servicio = FrasesService();
  late String _frase;

  @override
  void initState() {
    super.initState();
    _frase = _servicio.siguiente();
  }

  void _refrescar() {
    setState(() => _frase = _servicio.siguiente());
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Inspiración diaria')),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.format_quote,
                    size: 56,
                    color: tema.colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _frase,
                    key: const Key('frase'),
                    textAlign: TextAlign.center,
                    style: tema.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 32),
                  FilledButton.icon(
                    onPressed: _refrescar,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Otra frase'),
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