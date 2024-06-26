import 'package:flutter/material.dart';
import 'package:pos_si2_movil/screens/Menu/caja/TipoDeCobro/cobroSuccess.dart';

class CobroEfectivoScreen extends StatefulWidget {
  final double totalAmount; // Este valor debe ser pasado a la pantalla

  const CobroEfectivoScreen({super.key, required this.totalAmount});

  @override
  _CobroEfectivoScreenState createState() => _CobroEfectivoScreenState();
}

class _CobroEfectivoScreenState extends State<CobroEfectivoScreen> {
  final TextEditingController _paymentController = TextEditingController();
  double _change = 0.0;

  @override
  void initState() {
    super.initState();
    _paymentController.addListener(_calculateChange);
  }

  @override
  void dispose() {
    _paymentController.removeListener(_calculateChange);
    _paymentController.dispose();
    super.dispose();
  }

  void _calculateChange() {
    double payment = double.tryParse(_paymentController.text) ?? 0.0;
    setState(() {
      _change = payment - widget.totalAmount;
    });
  }

  Future<void> cobrarVenta() async {
    // Implementar la lógica para cobrar la venta
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CobroSuccessScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cobro en Efectivo'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Total a pagar: \$${widget.totalAmount.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _paymentController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Ingrese el monto recibido',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Cambio a devolver: \$ ${_change < 0 ? 'Monto Insuficiente' : _change.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: () {
                // Lógica para procesar el pago
                // ScaffoldMessenger.of(context).showSnackBar(
                //   const SnackBar(content: Text('Procesando Pago...')),
                // );
                cobrarVenta();
              },
              child: const Text('Pagar',
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
