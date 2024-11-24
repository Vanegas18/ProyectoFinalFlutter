import 'package:flutter/material.dart';

class CategoriaAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CategoriaAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // Título centrado de la AppBar
      title: const Center(
        child: Text(
          'CATEGORÍAS EN BUILDMART',
          style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
        ),
      ),
      // Colores de fondo y de primer plano de la AppBar
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    );
  }

  @override
  // Tamaño de la AppBar, en este caso, el tamaño por defecto
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
