import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pos_si2_movil/models/producto/ProductoPostSale.dart';
import 'package:pos_si2_movil/models/producto/ventaResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ComprasApi {
  static String? baseUrl = dotenv.env['API_URL'];

  Future<VentaResponse> compraPago(double cambio, double pago,
      String metodoPago, ProductPostSale productos, String correo) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('tokenTenant');
    final subdominio = prefs.getString('subdominio');
    final idCaja = prefs.getInt('idCaja');
    final idSucursal = prefs.getInt('idSucursal');
    try {
      final response = await http.post(Uri.parse('$baseUrl/sales'), headers: {
        'service-token': token!,
        'subdomain': subdominio!,
      }, body: {
        "atmId": idCaja,
        "branchId": idSucursal,

        "clientId": correo,
        // "nitClient": "",
        "change": cambio.toStringAsFixed(2),
        "pay": pago.toStringAsFixed(2),
        "type": metodoPago,
        "products": productos.toJson(),
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Si la solicitud fue exitosa, devuelve el token de acceso
        final data = VentaResponse.fromJson(json.decode(response.body));
        return data;
      } else {
        // Si la solicitud falló, lanza una excepción con el mensaje de error
        throw Exception('Error al iniciar sesión: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al iniciar sesión: $e');
    }
  }
}
