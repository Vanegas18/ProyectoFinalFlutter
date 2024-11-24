// widgets/categoria_table.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:proyecto_final/models/categoria_model.dart';

class CategoriaTable extends StatelessWidget {
  final List<CategoriaModel> categorias;
  final Function(String, String, String, String) onEdit;
  final Function(String, String) onUpdateState;

  const CategoriaTable({
    super.key,
    required this.categorias,
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
                  dataRowColor: WidgetStateProperty.all(Colors.deepPurple[50]),
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
                  // Definición de filas
                  rows: categorias.map((categoria) {
                    return DataRow(
                      cells: [
                        DataCell(Container(
                          width: 100.0,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            categoria.nombre,
                            style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                        DataCell(Container(
                          width: 250.0,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            categoria.descripcion,
                            style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                        DataCell(Container(
                          width: 100.0,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            categoria.estado,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: categoria.estado == 'inactivo'
                                  ? Colors.red
                                  : Colors.lightBlue,
                            ),
                          ),
                        )),
                        DataCell(Container(
                          width: 100.0,
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              // Botón de edición
                              IconButton(
                                onPressed: () {
                                  onEdit(
                                    categoria.id,
                                    categoria.nombre,
                                    categoria.descripcion,
                                    categoria.estado,
                                  );
                                },
                                icon:
                                    const Icon(Icons.edit, color: Colors.blue),
                              ),
                              // Botón de actualización de estado
                              IconButton(
                                onPressed: () {
                                  onUpdateState(
                                    categoria.id,
                                    categoria.estado,
                                  );
                                },
                                icon: const Icon(Icons.power_settings_new,
                                    color: Colors.red),
                              ),
                            ],
                          ),
                        )),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
