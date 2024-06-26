import 'package:flutter/material.dart';
import 'package:pos_si2_movil/Widgets/Boton.dart';
import 'package:pos_si2_movil/Widgets/indexText.dart';
import 'package:pos_si2_movil/api/auth_api.dart';
import 'package:pos_si2_movil/screens/auth/aperturaCajaScreen.dart';
import 'package:pos_si2_movil/screens/auth/tenantScreen.dart';

class LoginTenantScreen extends StatefulWidget {
  final String subdominio;
  final String correo;
  const LoginTenantScreen(
      {super.key, required this.subdominio, required this.correo});

  @override
  State<LoginTenantScreen> createState() => _LoginTenantScreenState();
}

class _LoginTenantScreenState extends State<LoginTenantScreen> {
  final TextEditingController _email =
      TextEditingController(text: 'empleado@example.com');
  final TextEditingController _subdominio = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Ahora puedes acceder a widget.subdominio
    _subdominio.text = widget.subdominio;
    _email.text = widget.correo;
  }

  Future<void> login() async {
    final auth = AuthApi();
    setState(() {
      _isLoading = true;
    });
    try {
      final response =
          await auth.loginTenant(_email.text, _password.text, _subdominio.text);

      if (response.statusCode == 200) {
        print(response.toJson());
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AperturaScreen()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.message),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
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
    var screen = MediaQuery.of(context).size;
    var padding = MediaQuery.of(context).padding;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ingresar al Subdominio'),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(color: Colors.white),
                width: screen.width,
                height: screen.height - padding.top,
                child: Column(
                  children: [
                    SizedBox(height: screen.height * 0.25),
                    // Campo de correo (solo lectura)
                    IndexText(
                      texto: _email,
                      textoEjemplo: 'Correo',
                      esSoloLectura: true,
                    ),

                    const SizedBox(height: 20),

                    IndexText(
                      texto: _subdominio,
                      textoEjemplo: 'Subdominio',
                      esSoloLectura: true,
                    ),

                    const SizedBox(height: 20),

                    // Campo de contraseña
                    IndexText(
                      texto: _password,
                      textoEjemplo: 'Contraseña',
                      esContrasena: true,
                    ),

                    const SizedBox(height: 20),
                    Boton(
                      onPressed: login,
                      text: 'Ingresar',
                    ),
                  ],
                ),
              ),
            ),
            if (_isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
