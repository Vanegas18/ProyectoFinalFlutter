//! Clase modelo para la entidad Productos
class ProductosModels {
  // Atributos de la clase
  final int id;
  final String nombre;
  final String categoria;
  final String descripcion;
  final double precio;
  final int stock;
  final String estado;

  // Constructor para inicializar los atributos
  ProductosModels(
      {required this.id,
      required this.nombre,
      required this.categoria,
      required this.descripcion,
      required this.precio,
      required this.stock,
      required this.estado});

  // factory es para que se pueda retornar una nueva instancia de la clase
  factory ProductosModels.fromJson(Map<String, dynamic> json) {
    return ProductosModels(
      id: json['_id'] ?? '',
      nombre: json['nombre'] ?? '',
      categoria: json['categoria'] ?? '',
      descripcion: json['descripcion'] ?? '',
      precio: json['precio'] ?? '',
      stock: json['stock'] ?? '',
      estado: json['estado'] ?? '',
    );
  }

  // Método para convertir los atributos de la clase a un mapa
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'nombre': nombre,
      'categoria': categoria,
      'descripcion': descripcion,
      'precio': precio,
      'stock': stock,
      'estado': estado,
    };
  }
}
