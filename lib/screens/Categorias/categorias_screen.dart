// ignore_for_file: use_build_context_synchronously, unused_element
// Importación de librerías y archivos
import 'package:flutter/material.dart';
import 'package:proyecto_final/controllers/categoria_controllers.dart';
import 'package:proyecto_final/models/categoria_model.dart';
import 'package:proyecto_final/screens/Categorias/appbar_categoria_screen.dart';
import 'package:proyecto_final/screens/Categorias/btn_agregar_scren.dart';
import 'package:proyecto_final/screens/Categorias/info_tablas_screen.dart';
import 'package:proyecto_final/screens/Categorias/modales_screen.dart';

// StatefulWidget ya que se necesita manejar el estado
class CategoriasScreen extends StatefulWidget {
  const CategoriasScreen({super.key});

  @override
  State<CategoriasScreen> createState() => _CategoriasScreenState();
}

// clase _CategoriasScreenState
class _CategoriasScreenState extends State<CategoriasScreen> {
  // Instancia de CategoriaControllers para poder usar sus métodos
  final CategoriaControllers _categoriaControllers = CategoriaControllers();

  // Lista de categorias
  List<CategoriaModel> categorias = []; // Aquí se guardaran las categorias
  TextEditingController _searchController = TextEditingController();
  List<CategoriaModel> _filteredCategorias = [];

  //! MÉTODOS

  // Método initState para inicializar el estado
  @override
  void initState() {
    super.initState();
    _listadoCategorias(); // Llamar al método para obtener las categorias
  }

  void _filterCategorias() {
    setState(() {
      _filteredCategorias = categorias
          .where((categoria) => categoria.nombre
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

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

  // Método para registrar una categoria
  Future _registrarCategoria(String nombre, String descripcion) async {
    try {
      await _categoriaControllers.createCategoria(nombre, descripcion);
      await _listadoCategorias(); // Actualizar la lista de categorias
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Categoría registrada correctamente'),
        backgroundColor: Colors.green,
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Error al registrar la categoría'),
        backgroundColor: Colors.red,
      ));
    }
  }

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

  //! MODALES

  // Método para mostrar el modal de registro
  void showRegisterModal() {
    final TextEditingController nombreController = TextEditingController();
    final TextEditingController descripcionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return RegisterModal(
          nombreController: nombreController,
          descripcionController: descripcionController,
          registrar: () async {
            await _registrarCategoria(
                nombreController.text, descripcionController.text);
          },
        );
      },
    );
  }

  // Método para mostrar el modal de edición
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
        return EditModal(
          nombreController: nombreController,
          descripcionController: descripcionController,
          estadoController: estadoController,
          actualizar: () async {
            await _editarCategoria(
                id, nombreController.text, descripcionController.text);
          },
        );
      },
    );
  }

  // Método para mostrar el modal de actualización de estado
  void showUpdateStateModal(String id, String estado) {
    showDialog(
      context: context,
      builder: (context) {
        return UpdateStateModal(
          estadoInicial: estado,
          cambiarEstado: (nuevoEstado) async {
            await _actualizarEstadoCategoria(id, nuevoEstado);
          },
        );
      },
    );
  }

  //! Renderizar la vista
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, '/dashboard');
        return true;
      },
      child: Scaffold(
        appBar: const CategoriaAppBar(),
        //-------------------------
        body: FutureBuilder<List<CategoriaModel>>(
          future: _categoriaControllers.getCategorias(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Error al obtener las categorias'),
              );
            } else {
              final categorias = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20.0),
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        labelText: 'Buscar categoría',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.search),
                      ),
                      onSubmitted: (value) {
                        _filterCategorias();
                      },
                    ),
                    const SizedBox(height: 20.0),
                    CategoriaAddButton(onPressed: showRegisterModal),
                    const SizedBox(height: 30.0),
                    //-------------------------
                    CategoriaTable(
                      categorias: _filteredCategorias.isEmpty
                          ? categorias
                          : _filteredCategorias,
                      onEdit: (id, nombre, descripcion, estado) {
                        showEditModal(id, nombre, descripcion, estado);
                      },
                      onUpdateState: (id, estado) {
                        showUpdateStateModal(id, estado);
                      },
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
