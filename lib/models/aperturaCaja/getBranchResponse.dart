// To parse this JSON data, do
//
//     final getbranchResponse = getbranchResponseFromJson(jsonString);

import 'dart:convert';

GetbranchResponse getbranchResponseFromJson(String str) =>
    GetbranchResponse.fromJson(json.decode(str));

String getbranchResponseToJson(GetbranchResponse data) =>
    json.encode(data.toJson());

class GetbranchResponse {
  int statusCode;
  String message;
  Data data;

  GetbranchResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory GetbranchResponse.fromJson(Map<String, dynamic> json) =>
      GetbranchResponse(
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
  List<Branch> branchs;

  Data({
    required this.total,
    required this.branchs,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        total: json["total"],
        branchs:
            List<Branch>.from(json["branchs"].map((x) => Branch.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "branchs": List<dynamic>.from(branchs.map((x) => x.toJson())),
      };
}

class Branch {
  int id;
  String address;
  bool status;
  String name;
  String createdAt;
  String updatedAt;
  City city;

  Branch({
    required this.id,
    required this.address,
    required this.status,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.city,
  });

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json["id"],
        address: json["address"],
        status: json["status"],
        name: json["name"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        city: City.fromJson(json["city"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address": address,
        "status": status,
        "name": name,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "city": city.toJson(),
      };
}

class City {
  int id;
  String name;
  bool status;
  DateTime createdAt;
  DateTime updatedAt;
  int tenantId;

  City({
    required this.id,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.tenantId,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        tenantId: json["tenantId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "tenantId": tenantId,
      };
}
