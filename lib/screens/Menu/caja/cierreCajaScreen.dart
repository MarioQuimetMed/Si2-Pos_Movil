import 'package:flutter/material.dart';
import 'package:pos_si2_movil/api/apertura_api.dart';
import 'package:pos_si2_movil/screens/auth/loginScreen.dart';

class CierreCajaScreen extends StatefulWidget {
  const CierreCajaScreen({Key? key}) : super(key: key);

  @override
  State<CierreCajaScreen> createState() => _CierreCajaScreenState();
}

class _CierreCajaScreenState extends State<CierreCajaScreen> {
  final TextEditingController _montoCierreController = TextEditingController();
  final aperturaApi = AperturaApi();
  bool _isLoading = false;

  Future<void> cerrarCaja() async {
    setState(() {
      _isLoading = true;
    });

    try {
      double montoCierre = double.parse(_montoCierreController.text);
      if (montoCierre <= 0) {
        return;
      }
      final response = await aperturaApi.cerrarCaja(montoCierre);
      if (response.statusCode == 201) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const LoginScreen()), // Reemplaza LoginPage() con la página a la que deseas navegar
          (Route<dynamic> route) =>
              false, // Esto asegura que se eliminen todas las rutas anteriores
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al cerrar la caja: ${response.message}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();

    final String fecha =
        '${now.year}-${_twoDigits(now.month)}-${_twoDigits(now.day)}';
    final String hora =
        '${_twoDigits(now.hour)}:${_twoDigits(now.minute)}:${_twoDigits(now.second)}';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cierre de Caja'),
        backgroundColor: Colors.teal,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                const SizedBox(height: 20),
                _buildInfoTile('Monto de Apertura:', '100.00 Bs'),
                const SizedBox(height: 20),
                _buildInfoTile('Fecha:', fecha),
                const SizedBox(height: 20),
                _buildInfoTile('Hora:', hora),
                const SizedBox(height: 20),
                _buildInfoTile('Nombre de la Caja:', 'Caja 1'),
                const SizedBox(height: 20),
                const Text(
                  'Monto de Cierre:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _montoCierreController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Ingrese el monto de cierre',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    cerrarCaja();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Cerrar Caja',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoTile(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  String _twoDigits(int n) {
    if (n >= 10) {
      return '$n';
    }
    return '0$n';
  }
}
