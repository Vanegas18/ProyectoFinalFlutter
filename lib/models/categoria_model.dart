//! Clase modelo para la entidad Categoria
class CategoriaModel {
  // Atributos de la clase
  String id;
  String nombre;
  String descripcion;
  String estado;

  // Constructor para inicializar los atributos
  CategoriaModel(
      {required this.id,
      required this.nombre,
      required this.descripcion,
      required this.estado});

  // factory es para que se pueda retornar una nueva instancia de la clase
  factory CategoriaModel.fromJson(Map<String, dynamic> json) {
    return CategoriaModel(
      id: json['_id'] ?? '',
      nombre: json['nombre'] ?? '',
      descripcion: json['descripcion'] ?? '',
      estado: json['estado'] ?? '',
    );
  }

  // Método para convertir los atributos de la clase a un mapa
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'estado': estado,
    };
  }
}
