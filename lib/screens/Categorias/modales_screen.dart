// widgets/categoria_modals.dart
// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';

// Modal para registrar una nueva categoría
class RegisterModal extends StatelessWidget {
  final TextEditingController nombreController;
  final TextEditingController descripcionController;
  final Function registrar;

  const RegisterModal({
    super.key,
    required this.nombreController,
    required this.descripcionController,
    required this.registrar,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Agregar Categoría'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            // Campo para el nombre de la categoría
            TextFormField(
              controller: nombreController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                hintText: 'Ingrese el nombre de la categoría',
                icon: Icon(Icons.category),
              ),
            ),
            // Campo para la descripción de la categoría
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
        // Botón para registrar la categoría
        TextButton(
          onPressed: () async {
            await registrar();
            Navigator.of(context).pop();
          },
          child: const Text('Registrar'),
        ),
        // Botón para cancelar el registro
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

// Modal para editar una categoría existente
class EditModal extends StatelessWidget {
  final TextEditingController nombreController;
  final TextEditingController descripcionController;
  final TextEditingController estadoController;
  final Function actualizar;

  const EditModal({
    super.key,
    required this.nombreController,
    required this.descripcionController,
    required this.estadoController,
    required this.actualizar,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar Categoría'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            // Campo para el nombre de la categoría
            TextFormField(
              controller: nombreController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                hintText: 'Ingrese el nombre de la categoría',
                icon: Icon(Icons.category),
              ),
            ),
            // Campo para la descripción de la categoría
            TextFormField(
              controller: descripcionController,
              decoration: const InputDecoration(
                labelText: 'Descripción',
                hintText: 'Ingrese la descripción de la categoría',
                icon: Icon(Icons.description),
              ),
            ),
            // Campo para el estado de la categoría (deshabilitado)
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
        // Botón para actualizar la categoría
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

// Modal para actualizar el estado de una categoría
class UpdateStateModal extends StatefulWidget {
  final String estadoInicial;
  final Function(String) cambiarEstado;

  const UpdateStateModal({
    super.key,
    required this.estadoInicial,
    required this.cambiarEstado,
  });

  @override
  _UpdateStateModalState createState() => _UpdateStateModalState();
}

// Estado del modal para actualizar el estado de una categoría
class _UpdateStateModalState extends State<UpdateStateModal> {
  late String estadoSeleccionado;

  @override
  void initState() {
    super.initState();
    estadoSeleccionado = widget.estadoInicial.toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Actualizar Estado'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            // Dropdown para seleccionar el estado de la categoría
            DropdownButtonFormField<String>(
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
            ),
          ],
        ),
      ),
      actions: [
        // Botón para actualizar el estado
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
