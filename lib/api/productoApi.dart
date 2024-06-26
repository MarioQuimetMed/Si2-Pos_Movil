import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pos_si2_movil/Widgets/Producto.dart';
import 'package:pos_si2_movil/models/producto/getProductoResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProductoApi {
  static String? baseUrl = dotenv.env['API_URL'];

  Future<List<Producto>> getProducto() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('tokenTenant');
    final subdominio = prefs.getString('subdominio');
    final idSucursal = prefs.getInt('idSucursal');
    const skip = 0;
    const limit = 20;
    final url =
        Uri.parse('$baseUrl/inventory/$idSucursal?skip=$skip&limit=$limit');
    try {
      final response = await http.get(url, headers: {
        'service-token': token!,
        'subdomain': subdominio!,
      });

      if (response.statusCode == 200) {
        // Si la solicitud fue exitosa, devuelve el token de acceso
        final data = GetProductResponse.fromJson(json.decode(response.body));
        List<Producto> productos = [];
        for (var index in data.data.products) {
          productos.add(Producto.fromJson(index));
        }
        return productos;
      } else {
        // Si la solicitud falló, lanza una excepción con el mensaje de error
        throw Exception('Error al iniciar sesión: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al iniciar sesión: $e');
    }
  }
}
