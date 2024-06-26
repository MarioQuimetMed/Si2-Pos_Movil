import 'package:flutter/material.dart';

class Boton extends StatelessWidget {
  final VoidCallback? onPressed;

  const Boton({Key? key, this.onPressed, required String text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 55,
      decoration: BoxDecoration(
        color: Colors.black12,
        border: Border.all(color: Colors.black12, width: 1), // Agrega un borde
        borderRadius: BorderRadius.circular(10), // Agrega bordes redondeados
      ),
      child: TextButton(
        onPressed: onPressed,
        child: const Text(
          'Ingresar',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}
