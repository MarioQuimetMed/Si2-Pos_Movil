import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Producto extends StatelessWidget {
  final String nombre;
  final double precio;
  final String imageUrl;
  Producto(
      {super.key,
      required this.nombre,
      required this.precio,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    return Container(
      width: screen.width,
      child: Card(
        child: Row(
          children: <Widget>[
            Image.network(
              imageUrl,
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
    );
  }
}
