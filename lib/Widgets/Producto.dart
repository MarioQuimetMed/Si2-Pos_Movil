import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pos_si2_movil/Widgets/productoDialog.dart';
import 'package:pos_si2_movil/models/producto/getProductoResponse.dart';

class Producto extends StatelessWidget {
  final int id;
  final String nombre;
  final double precio;
  final String? imageUrl;
  final String? descripcion;
  final double descuento;
  final cantidad;

  Producto(
      {super.key,
      required this.id,
      required this.imageUrl,
      required this.descripcion,
      required this.nombre,
      required this.precio,
      required this.descuento,
      this.cantidad});

  factory Producto.fromJson(ProductElement json) => Producto(
        id: json.stock.product.id,
        nombre: json.stock.product.name,
        precio: double.parse(json.stock.product.price),
        imageUrl: json.stock.product.images[0],
        descripcion: json.stock.product.description,
        descuento: double.parse(json.stock.product.discount),
        cantidad: json.cant,
      );

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        var cantidad = 1;
        // Aquí puedes manejar la selección del producto
        print('Producto seleccionado: $nombre');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ProductoDialog(
                id: id, nombre: nombre, precio: precio, descuento: descuento);
          },
        );
      },
      child: Container(
        width: screen.width,
        child: Card(
          child: Row(
            children: <Widget>[
              Image.network(
                imageUrl!,
                width: 100,
                height: 100,
              ),
              SizedBox(width: 10),
              Column(
                children: [
                  Text(nombre),
                  Text(precio.toString() + " Bs."),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
