import 'package:flutter/material.dart';
import 'package:pos_si2_movil/api/compras_api.dart';
import 'package:pos_si2_movil/models/producto/ProductoPostSale.dart';
import 'package:pos_si2_movil/screens/Menu/caja/TipoDeCobro/cobroSuccess.dart';

class CobroTarjetaScreen extends StatefulWidget {
  double pago;
  ProductPostSale productos;
  String correo;

  CobroTarjetaScreen(
      {super.key,
      required this.pago,
      required this.productos,
      required this.correo});

  @override
  _CobroTarjetaScreenState createState() => _CobroTarjetaScreenState();
}

class _CobroTarjetaScreenState extends State<CobroTarjetaScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cardNumberController = TextEditingController();
  final comprasApi = ComprasApi();

  Future<void> cobrarVenta() async {
    // Implementar la lógica para cobrar la venta
    try {
      final response = await comprasApi.compraPago(
          0, widget.pago, 'TARJETA', widget.productos, widget.correo);
      if (response.statusCode == 201) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CobroSuccessScreen(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al cobrar la venta: ${response.message}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      throw Exception('Error al cobrar la venta: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cobro con Tarjeta'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTextField(
                  controller: _cardNumberController,
                  labelText: 'Codigo de Factura',
                  hintText: '1234 5678 9012 3456',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el número de tarjeta';
                    }
                    if (value.length != 16) {
                      return 'El número de tarjeta debe tener 16 dígitos';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    // if (_formKey.currentState!.validate()) {
                    //   // Lógica para procesar el pago
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     const SnackBar(content: Text('Procesando Pago...')),
                    //   );
                    // }
                    cobrarVenta();
                  },
                  child: const Text('Pagar',
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: validator,
    );
  }
}
