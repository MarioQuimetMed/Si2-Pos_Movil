import 'package:pos_si2_movil/models/aperturaCaja/getCajaResponse.dart';

class Caja {
  int id;
  String nombre;
  int branchId;

  Caja({
    required this.id,
    required this.nombre,
    required this.branchId,
  });

  factory Caja.fromJson(Atm data) => Caja(
        id: data.id,
        nombre: data.name,
        branchId: data.branchId,
      );
}
