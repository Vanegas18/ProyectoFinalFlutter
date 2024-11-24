import 'package:flutter/material.dart';
import 'package:proyecto_final/screens/Categorias/categorias_screen.dart';

void main(List<String> args) {
  runApp(const Principal());
}

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Proyecto Final',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const CategoriasScreen(),
    );
  }
}
