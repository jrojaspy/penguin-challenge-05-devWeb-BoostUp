class Tarea { // declaracion de clase y propiedades
  final String id;
  final String titulo;
  final String descripcion;
  bool completada;

  Tarea({ // constructor de objeto
    required this.id,
    required this.titulo,
    this.descripcion = '',
    this.completada = false,  
  });

  Map<String, dynamic> toJson() => { // metodo de serializacion a json
        'id': id,
        'titulo': titulo,
        'descripcion': descripcion,
        'completada': completada,
      };
  
  factory Tarea.fromJson(Map<String, dynamic> json) => Tarea( // constructor de fabrica para deserializacion de json a objeto
        id: json['id'] as String,
        titulo: json['titulo'] as String,
        descripcion: json['descripcion'] as String? ?? '', // nullsafety operator para evitar errores si el valor es nulo
        completada: json['completada'] as bool? ?? false,
      );
}