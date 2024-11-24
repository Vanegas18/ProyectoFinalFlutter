import 'package:flutter/material.dart';
import 'package:proyecto_final/screens/Categorias/categorias_screen.dart';
import 'package:proyecto_final/screens/Inicio/home_screen.dart';
import 'package:proyecto_final/screens/Productos/productos_screen.dart';
import 'package:proyecto_final/screens/Inicio/dashboard_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Proyecto Final',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/productos': (context) => const ProductosScreen(),
        '/categorias': (context) => const CategoriasScreen(),
      },
    );
  }
}
