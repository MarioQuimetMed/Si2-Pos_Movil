import 'package:flutter/material.dart';
import 'dart:async';

class CobroSuccessScreen extends StatefulWidget {
  const CobroSuccessScreen({super.key});

  @override
  State<CobroSuccessScreen> createState() => _CobroSuccessScreenState();
}

class _CobroSuccessScreenState extends State<CobroSuccessScreen> {
  @override
  void initState() {
    super.initState();
    // Redirigir a /menu después de 5 segundos
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushNamed(context, '/menu');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green.withOpacity(0.1),
                ),
                padding: const EdgeInsets.all(20),
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 100,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Compra realizada con éxito',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Serás redirigido al menú principal en breve.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
