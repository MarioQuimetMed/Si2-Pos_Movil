import 'package:flutter/material.dart';
import 'package:pos_si2_movil/Widgets/Producto.dart';

class ProductosScreen extends StatelessWidget {
  const ProductosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ListView(
      children: [
        Producto(
            nombre: 'Coca cola',
            precio: 5,
            imageUrl:
                'https://th.bing.com/th/id/OIP.1kz3bYdpQsj9sjT8FGldggHaHa?rs=1&pid=ImgDetMain'),
        Producto(
            nombre: 'Vino Diablo',
            precio: 40,
            imageUrl:
                'https://th.bing.com/th/id/OIP.Nlp5MBXF2aQtniwjC4yhtAHaHa?rs=1&pid=ImgDetMain'),
      ],
    ));
  }
}
