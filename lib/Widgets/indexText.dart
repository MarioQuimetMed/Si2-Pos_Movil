import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IndexText extends StatelessWidget {
  final TextEditingController texto;
  final String textoEjemplo;
  final bool esContrasena;
  final bool esSoloLectura;
  final bool soloNumeros;

  const IndexText({
    Key? key,
    required this.texto,
    required this.textoEjemplo,
    this.esContrasena = false,
    this.esSoloLectura = false,
    this.soloNumeros = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        width: 300,
        height: 55,
        child: TextField(
          controller: texto,
          obscureText: esContrasena,
          readOnly: esSoloLectura,
          keyboardType: soloNumeros ? TextInputType.number : TextInputType.text,
          inputFormatters: soloNumeros
              ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
              : null,
          decoration: InputDecoration(
            hintText: textoEjemplo,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
