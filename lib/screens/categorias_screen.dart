//! Vista de las categorias

//-------------------------
// Importar librerías
import 'package:flutter/material.dart';
import 'package:proyecto_final/controllers/categoria_controllers.dart';
import 'package:proyecto_final/models/categoria_model.dart';

//-------------------------
// StatefulWidget ya que se necesita manejar el estado
class CategoriasScreen extends StatefulWidget {
  const CategoriasScreen({super.key});

  @override
  State<CategoriasScreen> createState() => _CategoriasScreenState();
}

//-------------------------
// clase _CategoriasScreenState
class _CategoriasScreenState extends State<CategoriasScreen> {
  // Instancia de CategoriaControllers para poder usar sus métodos
  final CategoriaControllers _categoriaControllers = CategoriaControllers();

  // Lista de categorias
  List<CategoriaModel> categorias = []; // Aquí se guardaran las categorias

  //-------------------------
  // Método para obtener las categorias
  Future<void> _listadoCategorias() async {
    try {
      final fetchCategorias = await _categoriaControllers.getCategorias();
      setState(() {
        categorias = fetchCategorias;
      }); // Actualizar el estado de la lista de categorias
    } catch (e) {
      AlertDialog(
        title: const Text('Error'),
        content: const Text('Error al obtener las categorias'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Aceptar'),
          )
        ],
      );
    }
  }

  //-------------------------
  // Renderizar la vista
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'CATEGORÍAS EN BUILDMART',
            style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
          ),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      //-------------------------
      body: FutureBuilder<List<CategoriaModel>>(
        future: _categoriaControllers.getCategorias(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final categorias = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const SizedBox(height: 20.0),
                  //-------------------------
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 12.0),
                      textStyle: const TextStyle(
                          fontFamily: 'Montserrat', fontSize: 18.0),
                    ),
                    child: const Text('Agregar Categoría'),
                  ),
                  const SizedBox(height: 30.0),
                  //-------------------------
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          'Desliza horizontalmente para ver más',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 14.0,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        //-------------------------
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columnSpacing:
                                  40.0, // Ajusta el espacio entre columnas
                              dividerThickness: 2.0,
                              headingRowColor:
                                  WidgetStateProperty.all(Colors.black),
                              dataRowColor: WidgetStateProperty.all(
                                  Colors.deepPurple[50]),
                              // ignore: deprecated_member_use
                              dataRowHeight:
                                  80.0, // Ajusta la altura de las filas
                              columns: const [
                                DataColumn(
                                    label: Text('NOMBRE',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Montserrat',
                                            fontSize: 16.0,
                                            color: Colors.white))),
                                DataColumn(
                                    label: Text('DESCRIPCIÓN',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Montserrat',
                                            fontSize: 16.0,
                                            color: Colors.white))),
                                DataColumn(
                                    label: Text('ESTADO',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Montserrat',
                                            fontSize: 16.0,
                                            color: Colors.white))),
                                DataColumn(
                                    label: Text('ACCIONES',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Montserrat',
                                            fontSize: 16.0,
                                            color: Colors.white)))
                              ],
                              //-------------------------
                              rows: categorias
                                  .map(
                                    (categoria) => DataRow(
                                      cells: [
                                        DataCell(Container(
                                            width:
                                                100.0, // Ajusta el ancho de la celda de nombre
                                            alignment: Alignment.centerLeft,
                                            child: Text(categoria.nombre,
                                                style: const TextStyle(
                                                    fontFamily:
                                                        'Montserrat')))),
                                        DataCell(Container(
                                            width:
                                                250.0, // Ajusta el ancho de la celda de descripción
                                            alignment: Alignment.centerLeft,
                                            child: Text(categoria.descripcion,
                                                style: const TextStyle(
                                                    fontFamily:
                                                        'Montserrat')))),
                                        DataCell(Container(
                                            width:
                                                100.0, // Ajusta el ancho de la celda de estado
                                            alignment: Alignment.centerLeft,
                                            child: Text(categoria.estado,
                                                style: const TextStyle(
                                                    fontFamily:
                                                        'Montserrat')))),
                                        DataCell(Container(
                                            width:
                                                100.0, // Ajusta el ancho de la celda de acciones
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: const Icon(Icons.edit,
                                                        color: Colors.blue)),
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: const Icon(
                                                        Icons
                                                            .power_settings_new,
                                                        color: Colors.red)),
                                              ],
                                            )))
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
