// To parse this JSON data, do
//
//     final getTenantResponse = getTenantResponseFromJson(jsonString);

import 'dart:convert';

GetTenantResponse getTenantResponseFromJson(String str) =>
    GetTenantResponse.fromJson(json.decode(str));

String getTenantResponseToJson(GetTenantResponse data) =>
    json.encode(data.toJson());

class GetTenantResponse {
  int statusCode;
  String message;
  Data data;

  GetTenantResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory GetTenantResponse.fromJson(Map<String, dynamic> json) =>
      GetTenantResponse(
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
  List<AllTenant> allTenants;
  int total;

  Data({
    required this.allTenants,
    required this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        allTenants: List<AllTenant>.from(
            json["allTenants"].map((x) => AllTenant.fromJson(x))),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "allTenants": List<dynamic>.from(allTenants.map((x) => x.toJson())),
        "total": total,
      };
}

class AllTenant {
  Rol rol;
  Tenant tenant;

  AllTenant({
    required this.rol,
    required this.tenant,
  });

  factory AllTenant.fromJson(Map<String, dynamic> json) => AllTenant(
        rol: Rol.fromJson(json["rol"]),
        tenant: Tenant.fromJson(json["tenant"]),
      );

  Map<String, dynamic> toJson() => {
        "rol": rol.toJson(),
        "tenant": tenant.toJson(),
      };
}

class Rol {
  int id;
  String desc;

  Rol({
    required this.id,
    required this.desc,
  });

  factory Rol.fromJson(Map<String, dynamic> json) => Rol(
        id: json["id"],
        desc: json["desc"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "desc": desc,
      };
}

class Tenant {
  int id;
  String hosting;
  String name;
  dynamic logo;
  String createdAt;
  String updatedAt;
  bool status;

  Tenant({
    required this.id,
    required this.hosting,
    required this.name,
    required this.logo,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
  });

  factory Tenant.fromJson(Map<String, dynamic> json) => Tenant(
        id: json["id"],
        hosting: json["hosting"],
        name: json["name"],
        logo: json["logo"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "hosting": hosting,
        "name": name,
        "logo": logo,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "status": status,
      };
}
