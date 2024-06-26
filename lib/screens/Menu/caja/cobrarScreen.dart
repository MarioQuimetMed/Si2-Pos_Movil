import 'package:flutter/material.dart';
import 'package:pos_si2_movil/Widgets/cartProvider.dart';
import 'package:pos_si2_movil/screens/Menu/caja/TipoDeCobro/cobroEfectivoScreen.dart';
import 'package:pos_si2_movil/screens/Menu/caja/TipoDeCobro/cobroQrScreen.dart';
import 'package:pos_si2_movil/screens/Menu/caja/TipoDeCobro/cobroTarjetaScreen.dart';
import 'package:provider/provider.dart';

class CobrarScreen extends StatelessWidget {
  final double total;
  final emailCliente;
  const CobrarScreen(
      {super.key, required this.total, required this.emailCliente});

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartProvider>(context);
    var productos = cart.toProductPostSale();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Seleccionar Método de Cobro',
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            _buildPaymentMethodButton(
              context,
              icon: Icons.attach_money,
              text: 'Efectivo',
              color: Colors.green,
              onTap: () {
                // Lógica para pago en efectivo CobroEfectivoScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CobroEfectivoScreen(
                            totalAmount: total,
                            correo: emailCliente,
                            productos: productos,
                          )),
                );
              },
            ),
            const SizedBox(height: 20),
            _buildPaymentMethodButton(
              context,
              icon: Icons.credit_card,
              text: 'Tarjeta',
              color: Colors.blue,
              onTap: () {
                // Lógica para pago con tarjeta
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CobroTarjetaScreen(
                            correo: emailCliente,
                            productos: productos,
                            pago: total,
                          )),
                );
              },
            ),
            const SizedBox(height: 20),
            _buildPaymentMethodButton(
              context,
              icon: Icons.qr_code,
              text: 'Código QR',
              color: Colors.purple,
              onTap: () {
                // Lógica para pago con código QR
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CobroQrScreen(
                            correo: emailCliente,
                            productos: productos,
                            pago: total,
                          )),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodButton(BuildContext context,
      {required IconData icon,
      required String text,
      required Color color,
      required VoidCallback onTap}) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20),
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onTap,
      icon: Icon(
        icon,
        size: 32,
        color: Colors.white,
      ),
      label: Text(
        text,
        style: const TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}
