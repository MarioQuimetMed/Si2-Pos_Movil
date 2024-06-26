// To parse this JSON data, do
//
//     final getCajaResponse = getCajaResponseFromJson(jsonString);

import 'dart:convert';

GetCajaResponse getCajaResponseFromJson(String str) =>
    GetCajaResponse.fromJson(json.decode(str));

String getCajaResponseToJson(GetCajaResponse data) =>
    json.encode(data.toJson());

class GetCajaResponse {
  int statusCode;
  String message;
  Data data;

  GetCajaResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory GetCajaResponse.fromJson(Map<String, dynamic> json) =>
      GetCajaResponse(
        statusCode: json["statusCode"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  int total;
  List<Atm> atms;

  Data({
    required this.total,
    required this.atms,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        total: json["total"],
        atms: List<Atm>.from(json["atms"].map((x) => Atm.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "atms": List<dynamic>.from(atms.map((x) => x.toJson())),
      };
}

class Atm {
  int id;
  String name;
  bool active;
  bool status;
  int branchId;
  DateTime createdAt;
  DateTime updatedAt;
  int tenantId;

  Atm({
    required this.id,
    required this.name,
    required this.active,
    required this.status,
    required this.branchId,
    required this.createdAt,
    required this.updatedAt,
    required this.tenantId,
  });

  factory Atm.fromJson(Map<String, dynamic> json) => Atm(
        id: json["id"],
        name: json["name"],
        active: json["active"],
        status: json["status"],
        branchId: json["branchId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        tenantId: json["tenantId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "active": active,
        "status": status,
        "branchId": branchId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "tenantId": tenantId,
      };
}
