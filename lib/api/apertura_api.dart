import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pos_si2_movil/models/Auth/authResponse.dart';
import 'package:pos_si2_movil/models/Auth/authTenantResponse.dart';
import 'package:pos_si2_movil/models/Auth/getTenantsResponse.dart';
import 'package:pos_si2_movil/models/aperturaCaja/Caja.dart';
import 'package:pos_si2_movil/models/aperturaCaja/Sucursal.dart';
import 'package:pos_si2_movil/models/aperturaCaja/atmCloseResponse.dart';
import 'package:pos_si2_movil/models/aperturaCaja/getBranchResponse.dart';
import 'package:pos_si2_movil/models/aperturaCaja/getCajaResponse.dart';
import 'package:pos_si2_movil/models/aperturaCaja/atmOpenResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AperturaApi {
  static String? baseUrl = dotenv.env['API_URL'];

  Future<List<Sucursal>> getSucursales() async {
    final url = Uri.parse('$baseUrl/control/branchs');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('tokenTenant');
    final subdominio = prefs.getString('subdominio');
    try {
      final response = await http.get(url, headers: {
        'service-token': token!,
        'subdomain': subdominio!,
      });

      if (response.statusCode == 200) {
        // Si la solicitud fue exitosa, devuelve el token de acceso
        final data = GetbranchResponse.fromJson(json.decode(response.body));
        List<Sucursal> sucursales = [];
        for (var index in data.data.branch) {
          sucursales.add(Sucursal.fromJson(index));
        }
        return sucursales;
      } else {
        // Si la solicitud falló, lanza una excepción con el mensaje de error
        throw Exception('Error al iniciar sesión: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al iniciar sesión: $e');
    }
  }

  Future<List<Caja>> getCajas(int idSucursal) async {
    final url = Uri.parse('$baseUrl/control/atms?branchId=$idSucursal');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('tokenTenant');
    final subdominio = prefs.getString('subdominio');
    try {
      final response = await http.get(url, headers: {
        'service-token': token!,
        'subdomain': subdominio!,
      });

      if (response.statusCode == 200) {
        // Si la solicitud fue exitosa, devuelve el token de acceso
        final data = GetCajaResponse.fromJson(json.decode(response.body));
        List<Caja> cajas = [];
        for (var index in data.data.atms) {
          cajas.add(Caja.fromJson(index));
        }
        return cajas;
      } else {
        // Si la solicitud falló, lanza una excepción con el mensaje de error
        throw Exception('Error al iniciar sesión: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al iniciar sesión: $e');
    }
  }

  Future<AtmOpenResponse> abrirCaja(
      int idSucursal, int idCaja, double montoApertura) async {
    final url = Uri.parse('$baseUrl/control/open');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('tokenTenant');
    final subdominio = prefs.getString('subdominio');
    try {
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'service-token': token!,
            'subdomain': subdominio!,
          },
          body: jsonEncode({
            'atmId': idCaja,
            'monto': montoApertura.toStringAsFixed(2),
          }));

      if (response.statusCode == 201) {
        final data = AtmOpenResponse.fromJson(json.decode(response.body));
        prefs.setInt('idCaja', idCaja);
        prefs.setInt('idSucursal', idSucursal);
        return data;
      } else {
        // Si la solicitud falló, lanza una excepción con el mensaje de error
        throw Exception('Error al abrir Caja: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al iniciar sesión: $e');
    }
  }

  Future<AtmCloseResponse> cerrarCaja(double montoCierre) async {
    final url = Uri.parse('$baseUrl/control/close');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('tokenTenant');
    final subdominio = prefs.getString('subdominio');
    final idCaja = prefs.getInt('idCaja');
    try {
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'service-token': token!,
            'subdomain': subdominio!,
          },
          body: jsonEncode({
            'atmId': idCaja,
            'monto': montoCierre.toStringAsFixed(2),
          }));

      if (response.statusCode == 201) {
        prefs.remove('idCaja');
        final data = AtmCloseResponse.fromJson(json.decode(response.body));
        return data;
      } else {
        // Si la solicitud falló, lanza una excepción con el mensaje de error
        throw Exception('Error al cerrar Caja: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al iniciar sesión: $e');
    }
  }
}
