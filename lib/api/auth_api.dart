import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pos_si2_movil/models/Auth/authResponse.dart';
import 'package:pos_si2_movil/models/Auth/authTenantResponse.dart';
import 'package:pos_si2_movil/models/Auth/getTenantsResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthApi {
  static String? baseUrl = dotenv.env['API_URL'];

  Future<AuthResponse> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');

    try {
      final response = await http.post(url, body: {
        'email': username,
        'password': password,
      });

      if (response.statusCode == 200) {
        // Si la solicitud fue exitosa, devuelve el token de acceso
        final prefs = await SharedPreferences.getInstance();
        final data = AuthResponse.fromJson(json.decode(response.body));
        prefs.setString('tokenSas', data.data.token);
        prefs.setString('correo', username);
        return data;
      } else {
        // Si la solicitud falló, lanza una excepción con el mensaje de error
        throw Exception('Error al iniciar sesión: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al iniciar sesión: $e');
    }
  }

  Future<AuthTenantResponse> loginTenant(
      String username, String password, String tenant) async {
    final url = Uri.parse('$baseUrl/auth/login/service');
    try {
      final response = await http.post(url, headers: {
        'subdomain': tenant
      }, body: {
        'email': username,
        'password': password,
      });

      if (response.statusCode == 200) {
        // Si la solicitud fue exitosa, devuelve el token de acceso

        final prefs = await SharedPreferences.getInstance();
        final data = AuthTenantResponse.fromJson(json.decode(response.body));
        prefs.setString('tokenTenant', data.data.token);
        prefs.setString('subdominio', tenant);
        return data;
      } else {
        // Si la solicitud falló, lanza una excepción con el mensaje de error
        throw Exception('Error al iniciar sesión: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al iniciar sesión: $e');
    }
  }

  Future<GetTenantResponse> getTenants() async {
    final url = Uri.parse('$baseUrl/tenant/user');
    final token = await SharedPreferences.getInstance().then((prefs) {
      return prefs.getString('tokenSas');
    });
    try {
      final response = await http.get(url, headers: {
        'auth-token': token!,
      });
      final data = GetTenantResponse.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        // Si la solicitud falló, lanza una excepción con el mensaje de error
        return data;
      }
      throw Exception('Error: ${data.message}');
    } catch (e) {
      throw Exception('Error : $e');
    }
  }
}
