//! Controllers para productos
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyecto_final/models/productos_models.dart';

class ProductoControllers {
  // URL base
  static const String url = 'https://buildmart-1.onrender.com/api/productos';

  // Método para obtener todas las categorías

  //! METODOS PARA PRODUCTOS

  // Metodo para obtener todos los productos (LISTAR)
  Future<List<ProductosModels>> getProductos() async {
    final response =
        await http.get(Uri.parse(url)); // Hacer una peticion GET a la API

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response
          .body); // Decodificar la respuesta de la API a JSON y guardarla en una variable
      final List<dynamic> productosData = jsonData[
          'productos']; // Guardar la lista de productos en una variable

      return productosData
          .map((item) => ProductosModels.fromJson(item))
          .toList(); // Mapear la lista de productos a una lista de objetos ProductosModels
    } else {
      throw Exception(
          'Error al obtener los productos'); // Lanzar un error si no se pudo obtener los productos
    }
  }

  // Metodo para crear un producto (AGREGAR)
  Future<void> createProducto(String nombre, String categoria,
      String descripcion, double precio, int stock,
      [String estado = 'Activo']) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"}, // Cabecera de la peticion
      body: jsonEncode({
        'nombre': nombre,
        'categoria': categoria,
        'descripcion': descripcion,
        'precio': precio,
        'stock': stock,
        'estado': estado
      }), // Cuerpo de la peticion
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(
          'Error al crear el producto'); // Lanzar un error si no se pudo crear el producto
    }
  }

  // Metodo para actualizar un producto (ACTUALIZAR)
  Future<void> updateProducto(String id, String nombre, String categoria,
      String descripcion, double precio, int stock) async {
    final response = await http.put(Uri.parse('$url/$id'),
        headers: {
          "Content-Type": "application/json"
        }, // Cabecera de la peticion
        body: jsonEncode({
          'nombre': nombre,
          'categoria': categoria,
          'descripcion': descripcion,
          'precio': precio,
          'stock': stock
        }) // Cuerpo de la peticion
        );
    if (response.statusCode != 200) {
      throw Exception(
          'Error al actualizar el producto'); // Lanzar un error si no se pudo actualizar el producto
    }
  }

  // Metodo para actualizar el estado de un producto (ACTUALIZAR)
  Future<void> updateEstadoProducto(String id, String estado) async {
    final response = await http.put(Uri.parse('$url/$id/estado'),
        headers: {
          "Content-Type": "application/json"
        }, // Cabecera de la peticion
        body: jsonEncode({'estado': estado}) // Cuerpo de la peticion
        );
    if (response.statusCode != 200) {
      throw Exception(
          'Error al actualizar el estado del producto'); // Lanzar un error si no se pudo actualizar el estado del producto
    }
  }
}
