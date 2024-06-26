import 'package:flutter/material.dart';
import 'package:pos_si2_movil/screens/Menu/caja/TipoDeCobro/cobroSuccess.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CobroQrScreen extends StatefulWidget {
  const CobroQrScreen({super.key});

  @override
  State<CobroQrScreen> createState() => _CobroQrScreenState();
}

class _CobroQrScreenState extends State<CobroQrScreen> {
  @override
  void initState() {
    super.initState();
    // Redirigir a /menu después de 5 segundos
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CobroSuccessScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cobro con Código QR'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Escanee el código QR para realizar el pago',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Center(
                child: QrImageView(
                    data: 'https://www.example.com/payment', size: 200)),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Lógica para confirmar el pago o volver al menú
                Navigator.pushNamed(context, '/menu');
              },
              child: const Text('Confirmar Pago'),
            ),
          ],
        ),
      ),
    );
  }
}
