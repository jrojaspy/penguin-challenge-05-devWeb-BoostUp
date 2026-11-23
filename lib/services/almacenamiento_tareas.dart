import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart'; // guardar datos simples en el dispositivo
import '../models/tarea.dart';

class AlmacenamientoTareas {
  static const String _clave = 'tareas_v1'; // llave o identificador para busqueda en almacenamiento local

  Future<List<Tarea>> cargar() async { // metodo asincrono
    final prefs = await SharedPreferences.getInstance();
    final texto = prefs.getString(_clave);
    if (texto == null) return [];

    try {
      final lista = jsonDecode(texto) as List<dynamic>;
      return lista
          .map((e) => Tarea.fromJson(e as Map<String, dynamic>)) // recorre cada elemento de la lista y lo convierte a Tarea
          .toList();
    } catch (e) {
      // Datos dañados: se empieza con una lista vacía en vez de fallar.
      return [];
    }
  }

  Future<void> guardar(List<Tarea> tareas) async {
    final prefs = await SharedPreferences.getInstance();
    final texto = jsonEncode(tareas.map((t) => t.toJson()).toList());
    await prefs.setString(_clave, texto);
  }
}