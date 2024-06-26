import 'package:flutter/material.dart';

class DevolucionesScreen extends StatefulWidget {
  const DevolucionesScreen({super.key});

  @override
  _DevolucionesScreenState createState() => _DevolucionesScreenState();
}

class _DevolucionesScreenState extends State<DevolucionesScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreProductoController =
      TextEditingController();
  final TextEditingController _cantidadController = TextEditingController();
  final TextEditingController _razonController = TextEditingController();

  bool _isLoading = false;

  Future<void> obtenerDevolucion() async {
    // Implementar la lógica de obtención de devolución
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _nombreProductoController,
                        decoration: InputDecoration(
                          labelText: 'Codigo de la Factura',
                          labelStyle: const TextStyle(color: Colors.deepPurple),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.deepPurple,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese el nombre del producto';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: _razonController,
                        decoration: InputDecoration(
                          labelText: 'Razón de la Devolución',
                          labelStyle: const TextStyle(color: Colors.deepPurple),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.deepPurple,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese la razón de la devolución';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24.0),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                _isLoading = true;
                              });
                              await obtenerDevolucion();
                              setState(() {
                                _isLoading = false;
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 15.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            backgroundColor: Colors.deepPurple,
                          ),
                          child: const Text(
                            'Realizar Devolución',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
