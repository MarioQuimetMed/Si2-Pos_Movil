import 'package:flutter/material.dart';
import 'package:pos_si2_movil/Widgets/Boton.dart';
import 'package:pos_si2_movil/Widgets/indexText.dart';
import 'package:pos_si2_movil/api/auth_api.dart';
import 'package:pos_si2_movil/screens/auth/tenantScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _isLoading = false;

  Future<void> login() async {
    final auth = AuthApi();
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await auth.login(_email.text, _password.text);

      if (response.statusCode == 201) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => TenantScreen()));
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
      body: SafeArea(
        child: Stack(
          children: [
            Container(
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
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  //Aca ingresa el codigo el empleado po
                  IndexText(
                    texto: _email,
                    textoEjemplo: 'Correo',
                  ),

                  const SizedBox(height: 20),

                  //Aca ingresa el codigo el empleado po
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
