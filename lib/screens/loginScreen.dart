import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _codigoEmpleado = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    var padding = MediaQuery.of(context).padding;
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        width: screen.width,
        height: screen.height - padding.top,
        child: Column(
          children: [
            SizedBox(height: screen.height * 0.25),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.store,
                  size: 40,
                  color: Colors.black,
                ),
                SizedBox(width: 20),
                Text(
                  'PointSync',
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.black,
                      decoration: TextDecoration.none),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Material(
              child: SizedBox(
                width: 300,
                height: 55,
                child: TextField(
                  controller: _codigoEmpleado,
                  decoration: InputDecoration(
                    hintText: 'Codigo de Empleado',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: 300,
              height: 55,
              decoration: BoxDecoration(
                color: Colors.black12,
                border: Border.all(
                    color: Colors.black12, width: 1), // Agrega un borde
                borderRadius:
                    BorderRadius.circular(10), // Agrega bordes redondeados
              ),
              child: TextButton(
                onPressed: () {
                  print(_codigoEmpleado.text);
                  Navigator.pushNamed(context, '/menu');
                  AlertDialog(
                    title: const Text("Ingresar Monto de apertura de caja"),
                    content: const Text(" Monto "),
                    actions: [
                      TextButton(
                        onPressed: () {
                          //Navigator.of(context).pop();
                          Navigator.pushNamed(context, '/menu');
                        },
                        child: const Text("Ingresar Monto"),
                      ),
                    ],
                  );
                },
                child: const Text(
                  'Ingresar',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
