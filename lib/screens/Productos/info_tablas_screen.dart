// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:proyecto_final/models/productos_models.dart';

class ProductosTable extends StatelessWidget {
  final List<ProductosModels> productos;
  final Function(String, String, String, String, double, int) onEdit;
  final Function(String, String) onUpdateState;

  const ProductosTable({
    super.key,
    required this.productos,
    required this.onEdit,
    required this.onUpdateState,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          // Texto de instrucción
          const Text(
            'Desliza horizontalmente para ver más',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 14.0,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10.0),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                    columnSpacing: 40.0,
                    dividerThickness: 2.0,
                    headingRowColor: WidgetStateProperty.all(Colors.black),
                    dataRowColor:
                        WidgetStateProperty.all(Colors.deepPurple[50]),
                    dataRowHeight: 80.0,
                    columns: const [
                      // Definición de columnas
                      DataColumn(
                        label: Text(
                          'NOMBRE',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'CATEGORÍA',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'DESCRIPCIÓN',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'PRECIO',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'STOCK',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'ESTADO',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'ACCIONES',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                    rows: productos.map((producto) {
                      return DataRow(cells: [
                        DataCell(Container(
                          width: 100.0,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            producto.nombre,
                            style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                        DataCell(Container(
                          width: 100.0,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            producto.categoria,
                            style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                        DataCell(Container(
                          width: 100.0,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            producto.descripcion,
                            style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                        DataCell(Container(
                          width: 100.0,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            producto.precio.toString(),
                            style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                        DataCell(Container(
                          width: 100.0,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            producto.stock.toString(),
                            style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                        DataCell(Container(
                          width: 100.0,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            producto.estado,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: producto.estado == 'Inactivo'
                                  ? Colors.red
                                  : Colors.lightBlue,
                            ),
                          ),
                        )),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                icon:
                                    const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  onEdit(
                                    producto.id,
                                    producto.nombre,
                                    producto.categoria,
                                    producto.descripcion,
                                    producto.precio,
                                    producto.stock,
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.power_settings_new,
                                    color: Colors.red),
                                onPressed: () {
                                  onUpdateState(
                                    producto.id,
                                    producto.estado,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ]);
                    }).toList()),
              ),
            ),
          )
        ],
      ),
    );
  }
}
