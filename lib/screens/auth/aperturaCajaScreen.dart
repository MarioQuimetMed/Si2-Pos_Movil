// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:pos_si2_movil/Widgets/Boton.dart';
import 'package:pos_si2_movil/Widgets/indexText.dart';
import 'package:pos_si2_movil/api/apertura_api.dart';
import 'package:pos_si2_movil/models/aperturaCaja/Caja.dart';
import 'package:pos_si2_movil/models/aperturaCaja/Sucursal.dart';

class AperturaScreen extends StatefulWidget {
  @override
  _AperturaScreenState createState() => _AperturaScreenState();
}

class _AperturaScreenState extends State<AperturaScreen> {
  String? sucursalDropdownValue;
  String? cajaDropdownValue;
  bool showMonto = false;
  bool isLoading = false; // Variable para mostrar la barra de carga
  double? montoApertura;
  AperturaApi aperturaApi = AperturaApi();
  final TextEditingController _monto = TextEditingController();
  late Future<List<Sucursal>> sucursalesFuture;
  Future<List<Caja>>? cajasFuture;
  int idCaja = 0;
  int idSucursal = 0;

  @override
  void initState() {
    super.initState();
    sucursalesFuture = obtenerSucursales();
  }

  Future<List<Sucursal>> obtenerSucursales() async {
    return await aperturaApi.getSucursales();
  }

  Future<List<Caja>> obtenerCajas(int idSucursal) async {
    return await aperturaApi.getCajas(idSucursal);
  }

  Future<void> abrirCaja() async {
    setState(() {
      isLoading = true; // Mostrar la barra de carga
    });
    try {
      montoApertura = double.parse(_monto.text);
      if (montoApertura! <= 0) {
        setState(() {
          isLoading = false; // Ocultar la barra de carga si hay un error
        });
        return;
      }
      final response =
          await aperturaApi.abrirCaja(idSucursal, idCaja, montoApertura!);

      if (response.statusCode == 201) {
        Navigator.pushNamed(context, '/menu');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al abrir la caja: ${response.message}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isLoading =
            false; // Ocultar la barra de carga cuando se complete la función
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apertura de Caja'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FutureBuilder<List<Sucursal>>(
                    future: sucursalesFuture,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Sucursal>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text('Error al cargar las sucursales'),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text('No hay sucursales disponibles'),
                        );
                      } else {
                        return _buildDropdown(
                          context,
                          value: sucursalDropdownValue,
                          hint: 'Seleccionar Sucursal',
                          items: snapshot.data!
                              .map((sucursal) => sucursal.nombre)
                              .toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              sucursalDropdownValue = newValue;
                              cajaDropdownValue = null;
                              showMonto = false;
                              int sucursalId = snapshot.data!
                                  .firstWhere(
                                      (sucursal) => sucursal.nombre == newValue)
                                  .id;
                              cajasFuture = obtenerCajas(sucursalId);
                              idSucursal = sucursalId;
                            });
                          },
                        );
                      }
                    },
                  ),
                  if (cajasFuture != null) ...[
                    const SizedBox(height: 20),
                    FutureBuilder<List<Caja>>(
                      future: cajasFuture,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Caja>> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: Text('Error al cargar las cajas'),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text('No hay cajas disponibles'),
                          );
                        } else {
                          return _buildDropdown(
                            context,
                            value: cajaDropdownValue,
                            hint: 'Seleccionar Caja',
                            items: snapshot.data!
                                .map((caja) => caja.nombre)
                                .toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                cajaDropdownValue = newValue;
                                idCaja = snapshot.data!
                                    .firstWhere(
                                        (caja) => caja.nombre == newValue)
                                    .id;
                                showMonto = true;
                                print('Id de la caja: $idCaja');
                              });
                            },
                          );
                        }
                      },
                    ),
                  ],
                  if (showMonto) ...[
                    const SizedBox(height: 20),
                    IndexText(
                      texto: _monto,
                      textoEjemplo: 'Ingresar Monto Bs.',
                      soloNumeros: true,
                    ),
                    const SizedBox(height: 20),
                    Boton(
                      onPressed: () {
                        abrirCaja();
                      },
                      text: 'Abrir Caja',
                    ),
                  ],
                ],
              ),
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDropdown(BuildContext context,
      {required String? value,
      required String hint,
      required List<String> items,
      required ValueChanged<String?> onChanged}) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onChanged: onChanged,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
