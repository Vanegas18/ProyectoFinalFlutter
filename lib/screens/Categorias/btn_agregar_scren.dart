// Importaciones necesarias
import 'package:flutter/material.dart';

// Definición del widget CategoriaAddButton
class CategoriaAddButton extends StatelessWidget {
  final VoidCallback onPressed;

  // Constructor del widget
  const CategoriaAddButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // Acción al presionar el botón
      onPressed: onPressed,
      // Estilo del botón
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        textStyle: const TextStyle(fontFamily: 'Montserrat', fontSize: 18.0),
      ),
      // Texto del botón
      child: const Text('Agregar Categoría'),
    );
  }
}
