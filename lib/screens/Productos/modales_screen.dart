// ignore_for_file: use_build_context_synchronously, unused_element

import 'package:flutter/material.dart';

// Modal para registrar un nuevo producto
class RegisterModal extends StatelessWidget {
  final TextEditingController nombreController;
  final TextEditingController categoriaController;
  final TextEditingController descripcionController;
  final TextEditingController precioController;
  final TextEditingController stockController;
  final Function registrar;

  const RegisterModal({
    super.key,
    required this.nombreController,
    required this.categoriaController,
    required this.descripcionController,
    required this.precioController,
    required this.stockController,
    required this.registrar,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Agregar Producto'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              controller: nombreController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                hintText: 'Ingrese el nombre del producto',
                icon: Icon(Icons.shopping_cart),
              ),
            ),
            TextFormField(
              controller: categoriaController,
              decoration: const InputDecoration(
                labelText: 'Categoría',
                hintText: 'Ingrese la categoría del producto',
                icon: Icon(Icons.category),
              ),
            ),
            TextFormField(
              controller: descripcionController,
              decoration: const InputDecoration(
                labelText: 'Descripción',
                hintText: 'Ingrese la descripción del producto',
                icon: Icon(Icons.description),
              ),
            ),
            TextFormField(
              controller: precioController,
              decoration: const InputDecoration(
                labelText: 'Precio',
                hintText: 'Ingrese el precio del producto',
                icon: Icon(Icons.attach_money),
              ),
            ),
            TextFormField(
              controller: stockController,
              decoration: const InputDecoration(
                labelText: 'Stock',
                hintText: 'Ingrese el stock del producto',
                icon: Icon(Icons.inventory),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            await registrar();
            Navigator.of(context).pop();
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
  }
}

// Modal para editar un producto
class EditModal extends StatelessWidget {
  final TextEditingController nombreController;
  final TextEditingController categoriaController;
  final TextEditingController descripcionController;
  final TextEditingController precioController;
  final TextEditingController stockController;
  final Function actualizar;

  const EditModal({
    super.key,
    required this.nombreController,
    required this.categoriaController,
    required this.descripcionController,
    required this.precioController,
    required this.stockController,
    required this.actualizar,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar Producto'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            // Campo para el nombre del producto
            TextFormField(
              controller: nombreController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                hintText: 'Ingrese el nombre del producto',
                icon: Icon(Icons.shopping_cart),
              ),
            ),
            // Campo para la categoría del producto
            TextFormField(
              controller: categoriaController,
              decoration: const InputDecoration(
                labelText: 'Categoría',
                hintText: 'Ingrese la categoría del producto',
                icon: Icon(Icons.category),
              ),
            ),
            // Campo para la descripción del producto
            TextFormField(
              controller: descripcionController,
              decoration: const InputDecoration(
                labelText: 'Descripción',
                hintText: 'Ingrese la descripción del producto',
                icon: Icon(Icons.description),
              ),
            ),
            // Campo para el precio del producto
            TextFormField(
              controller: precioController,
              decoration: const InputDecoration(
                labelText: 'Precio',
                hintText: 'Ingrese el precio del producto',
                icon: Icon(Icons.attach_money),
              ),
            ),
            // Campo para el stock del producto
            TextFormField(
              controller: stockController,
              decoration: const InputDecoration(
                labelText: 'Stock',
                hintText: 'Ingrese el stock del producto',
                icon: Icon(Icons.inventory),
              ),
            ),
          ],
        ),
      ),
      actions: [
        // Botón para actualizar el producto
        TextButton(
          onPressed: () async {
            await actualizar();
            Navigator.of(context).pop();
          },
          child: const Text('Actualizar'),
        ),
        // Botón para cancelar la actualización
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
      ],
    );
  }
}

// Modal para actualizar el estado de un producto
class ActualizarEstadoProducto extends StatefulWidget {
  final String estadoInicial;
  final Function(String) cambiarEstado;

  const ActualizarEstadoProducto(
      {super.key, required this.estadoInicial, required this.cambiarEstado});

  @override
  State<ActualizarEstadoProducto> createState() =>
      ActualizarEstadoProductoState();
}

class ActualizarEstadoProductoState extends State<ActualizarEstadoProducto> {
  late String estadoSeleccionado;

  @override
  void initState() {
    super.initState();
    estadoSeleccionado = widget.estadoInicial;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Actualizar Estado'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            // Dropdown para seleccionar el estado del producto
            DropdownButtonFormField<String>(
              value: estadoSeleccionado,
              items: const [
                DropdownMenuItem(
                  value: 'Inactivo',
                  child: Text('Inactivo'),
                ),
                DropdownMenuItem(
                  value: 'Activo',
                  child: Text('Activo'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  estadoSeleccionado = value!;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Estado',
                hintText: 'Seleccione el estado del producto',
                icon: Icon(Icons.check_circle),
              ),
            ),
          ],
        ),
      ),
      actions: [
        // Botón para actualizar el estado del producto
        TextButton(
          onPressed: () async {
            await widget.cambiarEstado(estadoSeleccionado);
            Navigator.of(context).pop();
          },
          child: const Text('Actualizar'),
        ),
        // Botón para cancelar la actualización
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
      ],
    );
  }
}
