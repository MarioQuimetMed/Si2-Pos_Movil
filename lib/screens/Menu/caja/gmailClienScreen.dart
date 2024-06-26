import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pos_si2_movil/Widgets/indexText.dart';
import 'package:pos_si2_movil/screens/Menu/caja/cobrarScreen.dart';

class GmailClientScreen extends StatefulWidget {
  final total;
  GmailClientScreen({super.key, required this.total});

  @override
  State<GmailClientScreen> createState() => _GmailClientScreenState();
}

class _GmailClientScreenState extends State<GmailClientScreen> {
  final TextEditingController _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Facturación Electrónica'),
          backgroundColor: Colors.teal,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Ingresar Correo del Cliente',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    const SizedBox(height: 20),
                    IndexText(
                      texto: _email,
                      textoEjemplo: 'correo@cliente.com',
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Implementar la lógica de envío de correo
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CobrarScreen(
                                    total: widget.total,
                                    emailCliente: _email.text,
                                  )),
                        );
                      },
                      label: const Text('Proceder con el cobro'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.teal,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
