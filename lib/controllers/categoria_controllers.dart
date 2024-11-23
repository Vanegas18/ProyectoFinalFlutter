//! Controllers para categorias
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyecto_final/models/categoria_model.dart';

class CategoriaControllers {
  // URL base
  static const String url = 'https://buildmart-1.onrender.com/api/categorias';

  //! METODOS PARA CATEGORIAS

  // Metodo para obtener todas las categorias (LISTAR)
  Future<List<CategoriaModel>> getCategorias() async {
    final response =
        await http.get(Uri.parse(url)); // Hacer una peticion GET a la API

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response
          .body); // Decodificar la respuesta de la API a JSON y guardarla en una variable
      final List<dynamic> categoriasData = jsonData[
          'categorias']; // Guardar la lista de categorias en una variable

      return categoriasData
          .map((item) => CategoriaModel.fromJson(item))
          .toList(); // Mapear la lista de categorias a una lista de objetos CategoriaModel
    } else {
      throw Exception(
          'Error al obtener las categorias'); // Lanzar un error si no se pudo obtener las categorias
    }
  }

  // Metodo para crear una categoria (AGREGAR)
  Future<void> createCategoria(String nombre, String descripcion,
      [String estado = 'Activo']) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"}, // Cabecera de la peticion
      body: jsonEncode({
        'nombre': nombre,
        'descripcion': descripcion,
        'estado': estado
      }), // Cuerpo de la peticion
    );
    if (response.statusCode != 200) {
      throw Exception(
          'Error al crear la categoria'); // Lanzar un error si no se pudo crear la categoria
    }
  }

  // Metodo para actualizar una categoria (ACTUALIZAR)
  Future<void> updateCategoria(
      String id, String nombre, String descripcion) async {
    final response = await http.put(Uri.parse('$url/$id'),
        headers: {
          "Content-Type": "application/json"
        }, // Cabecera de la peticion
        body: jsonEncode({
          'nombre': nombre,
          'descripcion': descripcion
        }) // Cuerpo de la peticion
        );
    if (response.statusCode != 200) {
      throw Exception(
          'Error al actualizar la categoria'); // Lanzar un error si no se pudo actualizar la categoria
    }
  }

  // Metodo para actualizar el estado de una categoria (ACTUALIZAR)
  // Metodo para actualizar el estado de una categoria (ACTUALIZAR)
  Future<void> updateEstadoCategoria(String id, String estado) async {
    final response = await http.put(Uri.parse('$url/$id/estado'),
        headers: {
          "Content-Type": "application/json"
        }, // Cabecera de la peticion
        body: jsonEncode({'estado': estado}) // Cuerpo de la peticion
        );
    if (response.statusCode != 200) {
      throw Exception(
          'Error al actualizar el estado de la categoria'); // Lanzar un error si no se pudo actualizar el estado de la categoria
    }
  }
}
