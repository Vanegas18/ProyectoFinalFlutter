//! Clase principal de la aplicación

// Importaciones
import 'package:flutter/material.dart';
import 'package:proyecto_final/screens/categorias_screen.dart';

// Clase principal de la aplicación
void main(List<String> args) {
  runApp(const Principal());
}

// Clase Principal
class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

// Clase _PrincipalState
class _PrincipalState extends State<Principal> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Proyecto Final',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CategoriasScreen(),
    );
  }
}
