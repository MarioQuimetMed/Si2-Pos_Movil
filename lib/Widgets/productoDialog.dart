import 'package:flutter/material.dart';
import 'package:pos_si2_movil/Widgets/Producto.dart';
import 'package:pos_si2_movil/Widgets/cartProvider.dart';
import 'package:provider/provider.dart';

class ProductoDialog extends StatefulWidget {
  final String nombre;
  final double precio;
  final double descuento;
  final int id;

  ProductoDialog(
      {required this.nombre,
      required this.precio,
      required this.descuento,
      required this.id});

  @override
  _ProductoDialogState createState() => _ProductoDialogState();
}

class _ProductoDialogState extends State<ProductoDialog> {
  int cantidad = 1;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Agregar al carrito",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Producto: ${widget.nombre}",
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8.0),
          Text(
            "Precio: ${(widget.precio - (widget.precio * (widget.descuento / 100))).toStringAsFixed(2)} Bs.",
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Cantidad:",
                style: TextStyle(fontSize: 16),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (cantidad > 1) cantidad--;
                      });
                    },
                    icon: const Icon(Icons.remove, color: Colors.red),
                  ),
                  Text(
                    '$cantidad',
                    style: const TextStyle(fontSize: 16),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        cantidad++;
                      });
                    },
                    icon: const Icon(Icons.add, color: Colors.green),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            "Total: ${((widget.precio - (widget.precio * (widget.descuento / 100))) * cantidad).toStringAsFixed(2)} Bs.",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Cerrar el diálogo
          },
          child: const Text(
            "Cancelar",
            style: TextStyle(color: Colors.red),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            // Agregar la lógica para añadir el producto al carrito
            var cart = Provider.of<CartProvider>(context, listen: false);
            var producto = Producto(
              id: widget.id,
              nombre: widget.nombre,
              precio: widget.precio,
              imageUrl: '',
              descripcion: '',
              descuento: widget.descuento,
            );
            cart.addItem(producto, cantidad);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Producto añadido al carrito'),
                duration: Duration(seconds: 2),
              ),
            );
            Navigator.of(context).pop(); // Cerrar el diálogo
          },
          child: const Text("Agregar al carrito"),
        ),
      ],
    );
  }
}
