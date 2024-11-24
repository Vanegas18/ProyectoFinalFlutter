// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:proyecto_final/controllers/producto_controllers.dart';
import 'package:proyecto_final/models/productos_models.dart';
import 'package:proyecto_final/screens/Productos/appbar_producto.dart';
import 'package:proyecto_final/screens/Productos/btn_agregar_screen.dart';
import 'package:proyecto_final/screens/Productos/info_tablas_screen.dart';
import 'package:proyecto_final/screens/Productos/modales_screen.dart';

class ProductosScreen extends StatefulWidget {
  const ProductosScreen({super.key});

  @override
  State<ProductosScreen> createState() => _ProductosScreenState();
}

class _ProductosScreenState extends State<ProductosScreen> {
  // Instancia de ProductoControllers para poder usar sus métodos
  final ProductoControllers _productoControllers = ProductoControllers();

  // Lista de productos y categorías
  List<ProductosModels> productos = [];

  //! MÉTODOS

  // Método initState para inicializar el estado
  @override
  void initState() {
    super.initState();
    _listadoProductos(); // Llamar al método para obtener los productos
  }

  // Método para obtener los productos
  Future<void> _listadoProductos() async {
    try {
      final fetchProductos = await _productoControllers.getProductos();
      setState(() {
        productos = fetchProductos;
      }); // Actualizar el estado de la lista de productos
    } catch (e) {
      AlertDialog(
        title: const Text('Error'),
        content: const Text('Error al obtener los productos'),
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

  // Método para registrar un producto
  Future _registrarProducto(String nombre, String categoria, String descripcion,
      double precio, int stock) async {
    try {
      await _productoControllers.createProducto(
          nombre, categoria, descripcion, precio, stock);
      await _listadoProductos(); // Llamar al método para obtener los productos
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Producto registrado correctamente'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error al registrar el producto'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Método para actualizar un producto
  Future _editarProducto(String id, String nombre, String categoria,
      String descripcion, double precio, int stock) async {
    try {
      await _productoControllers.updateProducto(
          id, nombre, categoria, descripcion, precio, stock);
      await _listadoProductos(); // Llamar al método para obtener los productos
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Producto actualizado correctamente'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error al actualizar el producto'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Método para actualizar el estado de un producto
  Future _actualizarEstadoProducto(String id, String estado) async {
    try {
      await _productoControllers.updateEstadoProducto(id, estado);
      await _listadoProductos(); // Llamar al método para obtener los productos
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Estado del producto actualizado correctamente'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error al actualizar el estado del producto'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  //! MODALES

  // Método para mostrar el modal de registro
  void showRegisterModal() async {
    final TextEditingController nombreController = TextEditingController();
    final TextEditingController categoriaController = TextEditingController();
    final TextEditingController descripcionController = TextEditingController();
    final TextEditingController precioController = TextEditingController();
    final TextEditingController stockController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return RegisterModal(
          nombreController: nombreController,
          categoriaController: categoriaController,
          descripcionController: descripcionController,
          precioController: precioController,
          stockController: stockController,
          registrar: () async {
            await _registrarProducto(
                nombreController.text,
                categoriaController.text,
                descripcionController.text,
                double.parse(precioController.text),
                int.parse(stockController.text));
          },
        );
      },
    );
  }

  // Método para mostrar el modal de edición
  void showEditModal(String id, String nombre, String categoria,
      String descripcion, double precio, int stock) {
    final TextEditingController nombreController =
        TextEditingController(text: nombre);
    final TextEditingController categoriaController =
        TextEditingController(text: categoria);
    final TextEditingController descripcionController =
        TextEditingController(text: descripcion);
    final TextEditingController precioController =
        TextEditingController(text: precio.toString());
    final TextEditingController stockController =
        TextEditingController(text: stock.toString());

    showDialog(
        context: context,
        builder: (context) {
          return EditModal(
              nombreController: nombreController,
              categoriaController: categoriaController,
              descripcionController: descripcionController,
              precioController: precioController,
              stockController: stockController,
              actualizar: () async {
                await _editarProducto(
                    id,
                    nombreController.text,
                    categoriaController.text,
                    descripcionController.text,
                    double.parse(precioController.text),
                    int.parse(stockController.text));
              });
        });
  }

  // Método para mostrar el modal de actualización de estado
  void showUpdateStateModal(String id, String estado) {
    showDialog(
        context: context,
        builder: (context) {
          return ActualizarEstadoProducto(
              estadoInicial: estado,
              cambiarEstado: (nuevoEstado) async {
                await _actualizarEstadoProducto(id, nuevoEstado);
              });
        });
  }

  //! RENDERIZADO
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ProductoAppBar(),
      body: FutureBuilder<List<ProductosModels>>(
          future: _productoControllers.getProductos(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Error al obtener los productos'),
              );
            } else {
              final productos = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20.0),
                    ProductosAddBtn(onPressed: showRegisterModal),
                    const SizedBox(height: 20.0),

                    // Listado de productos
                    ProductosTable(
                      productos: productos,
                      onEdit:
                          (id, nombre, categoria, descripcion, precio, stock) {
                        showEditModal(
                            id, nombre, categoria, descripcion, precio, stock);
                      },
                      onUpdateState: (id, estado) {
                        showUpdateStateModal(id, estado);
                      },
                    )
                  ],
                ),
              );
            }
          }),
    );
  }
}
