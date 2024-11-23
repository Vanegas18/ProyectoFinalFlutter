//! Vista de las categorias

// ignore_for_file: use_build_context_synchronously, unused_element

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
  // Método initState
  @override
  void initState() {
    super.initState();
    _listadoCategorias(); // Llamar al método para obtener las categorias
  }

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
  // Método para registrar una categoria
  Future _registrarCategoria(String nombre, String descripcion) async {
    try {
      await _categoriaControllers.createCategoria(nombre, descripcion);
      await _listadoCategorias(); // Actualizar la lista de categorias
      AlertDialog(
        title: const Text('Éxito'),
        content: const Text('Categoría registrada correctamente'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Aceptar'),
          )
        ],
      );
    } catch (e) {
      AlertDialog(
        title: const Text('Error'),
        content: const Text('Error al registrar la categoría'),
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
  // Método para actualizar una categoria
  Future _editarCategoria(String id, String nombre, String descripcion) async {
    try {
      await _categoriaControllers.updateCategoria(id, nombre, descripcion);
      await _listadoCategorias(); // Actualizar la lista de categorias
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Categoría actualizada correctamente'),
        backgroundColor: Colors.green,
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Error al actualizar la categoría'),
        backgroundColor: Colors.red,
      ));
    }
  }

  //-------------------------
  // Método para actualizar el estado de una categoria
  Future _actualizarEstadoCategoria(String id, String estado) async {
    try {
      await _categoriaControllers.updateEstadoCategoria(id, estado);
      await _listadoCategorias(); // Actualizar la lista de categorias
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Estado de la categoría actualizado correctamente'),
        backgroundColor: Colors.green,
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Error al actualizar el estado de la categoría'),
        backgroundColor: Colors.red,
      ));
    }
  }

  //-------------------------
  // Modal para agregar una categoria
  void showRegisterModal() {
    final TextEditingController nombreController = TextEditingController();
    final TextEditingController descripcionController = TextEditingController();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Agregar Categoría'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: nombreController,
                    decoration: const InputDecoration(
                      labelText: 'Nombre',
                      hintText: 'Ingrese el nombre de la categoría',
                      icon: Icon(Icons.category),
                    ),
                  ),
                  TextFormField(
                    controller: descripcionController,
                    decoration: const InputDecoration(
                      labelText: 'Descripción',
                      hintText: 'Ingrese la descripción de la categoría',
                      icon: Icon(Icons.description),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  try {
                    // Llamar al método para registrar la categoria
                    await _categoriaControllers.createCategoria(
                        nombreController.text, descripcionController.text);

                    // Actualizar la lista de categorias
                    await _listadoCategorias();

                    // Llamar a setState para actualizar la interfaz de usuario
                    setState(() {});

                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Categoría registrada correctamente'),
                      backgroundColor: Colors.green,
                    ));
                  } catch (e) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Error al registrar la categoría'),
                      backgroundColor: Colors.red,
                    ));
                  }
                },
                child: const Text('Registrar'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancelar'),
              ),
            ],
          );
        });
  }

  //-------------------------
  // Modal para editar una categoria
  void showEditModal(
      String id, String nombre, String descripcion, String estado) {
    final TextEditingController nombreController =
        TextEditingController(text: nombre);
    final TextEditingController descripcionController =
        TextEditingController(text: descripcion);
    final TextEditingController estadoController =
        TextEditingController(text: estado);

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Editar Categoría'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: nombreController,
                    decoration: const InputDecoration(
                      labelText: 'Nombre',
                      hintText: 'Ingrese el nombre de la categoría',
                      icon: Icon(Icons.category),
                    ),
                  ),
                  TextFormField(
                    controller: descripcionController,
                    decoration: const InputDecoration(
                      labelText: 'Descripción',
                      hintText: 'Ingrese la descripción de la categoría',
                      icon: Icon(Icons.description),
                    ),
                  ),
                  TextFormField(
                    controller: estadoController,
                    decoration: const InputDecoration(
                      labelText: 'Estado',
                      icon: Icon(Icons.check_circle),
                    ),
                    enabled: false,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  try {
                    // Llamar al método para actualizar la categoria
                    await _categoriaControllers.updateCategoria(
                        id, nombreController.text, descripcionController.text);

                    // Actualizar la lista de categorias
                    await _listadoCategorias();

                    // Llamar a setState para actualizar la interfaz de usuario
                    setState(() {});

                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Categoría actualizada correctamente'),
                      backgroundColor: Colors.green,
                    ));
                  } catch (e) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Error al actualizar la categoría $e'),
                      backgroundColor: Colors.red,
                    ));
                  }
                },
                child: const Text('Actualizar'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancelar'),
              ),
            ],
          );
        });
  }

  //-------------------------
  // Modal para actualizar el estado de una categoria
  void showUpdateStateModal(String id, String estado) {
    String estadoSeleccionado = estado.toLowerCase();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Actualizar Estado'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return DropdownButtonFormField<String>(
                      value: estadoSeleccionado,
                      items: const [
                        DropdownMenuItem(
                          value: 'activo',
                          child: Text('Activo'),
                        ),
                        DropdownMenuItem(
                          value: 'inactivo',
                          child: Text('Inactivo'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          estadoSeleccionado = value!;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Estado',
                        icon: Icon(Icons.check_circle),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                try {
                  // Llamar al método para actualizar el estado de la categoria
                  await _actualizarEstadoCategoria(id, estadoSeleccionado);

                  // Actualizar la lista de categorias
                  await _listadoCategorias();

                  // Llamar a setState para actualizar la interfaz de usuario
                  setState(() {});

                  Navigator.of(context).pop();
                } catch (e) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content:
                        Text('Error al actualizar el estado de la categoría'),
                    backgroundColor: Colors.red,
                  ));
                }
              },
              child: const Text('Actualizar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
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
                    onPressed: () {
                      showRegisterModal();
                    },
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
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
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
                                                      onPressed: () {
                                                        showEditModal(
                                                          categoria.id,
                                                          categoria.nombre,
                                                          categoria.descripcion,
                                                          categoria.estado,
                                                        );
                                                      },
                                                      icon: const Icon(
                                                          Icons.edit,
                                                          color: Colors.blue)),
                                                  IconButton(
                                                      onPressed: () {
                                                        showUpdateStateModal(
                                                            categoria.id,
                                                            categoria.estado);
                                                      },
                                                      icon: const Icon(
                                                          Icons
                                                              .power_settings_new,
                                                          color: Colors.red)),
                                                ],
                                              ))),
                                        ],
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                          // const SizedBox(height: 30.0),
                        )
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
