import 'package:pos_si2_movil/models/aperturaCaja/getBranchResponse.dart';

class Sucursal {
  final int id;
  final String nombre;
  final String direccion;

  Sucursal({
    required this.id,
    required this.nombre,
    required this.direccion,
  });

  factory Sucursal.fromJson(Branch json) => Sucursal(
        id: json.id,
        nombre: json.name,
        direccion: json.address,
      );
}
