import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 150),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('BUILD-MART',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 6,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black,
                            offset: Offset(5.0, 5.0),
                          ),
                        ]),
                    textAlign: TextAlign.center),
              ),
              const Icon(
                Icons.construction,
                size: 100,
                color: Colors.blue,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/dashboard');
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.blue,
                  backgroundColor: Colors.white, // Color del texto
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Ir al Dashboard',
                    style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
                child: const Text('Cerrar Sesión',
                    style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 30),
              const Spacer(),
              const Text(
                'Desarrollador: Juan Jose Vanegas\nCelular: 3006764605',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
