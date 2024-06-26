import 'package:flutter/material.dart';
import 'package:pos_si2_movil/api/auth_api.dart';
import 'package:pos_si2_movil/screens/auth/loginTenantScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TenantScreen extends StatefulWidget {
  const TenantScreen({super.key});

  @override
  State<TenantScreen> createState() => _TenantScreenState();
}

class _TenantScreenState extends State<TenantScreen> {
  List<String> subdominios = [];
  late Future<void> subdominiosFuture;

  Future<void> getSubdominios() async {
    try {
      // Lógica para obtener los subdominios
      final response = await AuthApi().getTenants();
      subdominios = List<String>.from(
          response.data.allTenants.map((tenant) => tenant.tenant.hosting));
      print(subdominios);
      print('Subdominios obtenidos con éxito');
    } catch (e) {
      print('Error al obtener los subdominios: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    subdominiosFuture = getSubdominios();
  }

  void _onSubdominioSelected(String subdominio) async {
    // Realiza la acción deseada cuando se selecciona un subdominio
    print('Subdominio seleccionado: $subdominio');
    final prefs = await SharedPreferences.getInstance();
    String correo = prefs.getString('correo')!;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginTenantScreen(
          subdominio: subdominio,
          correo: correo,
        ),
      ),
    );
    // Aquí puedes agregar cualquier lógica adicional que necesites
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecciona un subdominio'),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<void>(
            future: subdominiosFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                  ),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Error al cargar los subdominios'),
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: subdominios.map((subdominio) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          backgroundColor: Colors.deepPurpleAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 5,
                        ),
                        onPressed: () => _onSubdominioSelected(subdominio),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.domain, color: Colors.white),
                                const SizedBox(width: 10),
                                Text(
                                  subdominio,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const Icon(Icons.arrow_forward_ios,
                                color: Colors.white),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              }
            },
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
