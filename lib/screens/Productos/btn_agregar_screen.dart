import 'package:flutter/material.dart';

class ProductosAddBtn extends StatelessWidget {
  final VoidCallback
      onPressed; // El botón se activa al presionar, voidCallback es una función que no recibe ni devuelve nada

  const ProductosAddBtn({super.key, required this.onPressed});

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
      child: const Text('Agregar Producto'),
    );
  }
}
