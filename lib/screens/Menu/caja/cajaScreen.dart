import 'package:flutter/material.dart';
import 'package:pos_si2_movil/Widgets/cartProvider.dart';
import 'package:pos_si2_movil/screens/Menu/caja/cobrarScreen.dart';
import 'package:pos_si2_movil/screens/Menu/caja/gmailClienScreen.dart';
import 'package:provider/provider.dart';

class CajaScreen extends StatelessWidget {
  const CajaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartProvider>(context);

    double total = cart.items.fold(
      0.0,
      (sum, item) =>
          sum +
          (item.quantity *
              (item.producto.precio -
                  (item.producto.precio * (item.producto.descuento / 100)))),
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Lista de Productos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (context, index) {
                  var elemento = cart.items[index];
                  return ListTile(
                    leading: const Icon(Icons.shopping_cart),
                    title: Text(elemento.producto.nombre),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                cart.decrementQuantity(elemento);
                              },
                              icon: const Icon(Icons.remove),
                              color: Colors.red,
                            ),
                            Text(elemento.quantity.toString()),
                            IconButton(
                              onPressed: () {
                                cart.incrementQuantity(elemento.producto);
                              },
                              icon: const Icon(Icons.add),
                              color: Colors.green,
                            ),
                          ],
                        ),
                        Text(
                          '\$${(elemento.quantity * (elemento.producto.precio - (elemento.producto.precio * (elemento.producto.descuento / 100)))).toStringAsFixed(2)}',
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            if (cart.items.isNotEmpty) ...[
              Text(
                'Total: \$${total.toStringAsFixed(2)}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                  // Lógica para cobrar la venta
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GmailClientScreen(
                              total: total,
                            )),
                  );
                },
                child: const Text(
                  'Cobrar venta',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
