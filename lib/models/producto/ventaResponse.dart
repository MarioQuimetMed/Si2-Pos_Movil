// To parse this JSON data, do
//
//     final ventaResponse = ventaResponseFromJson(jsonString);

import 'dart:convert';

VentaResponse ventaResponseFromJson(String str) =>
    VentaResponse.fromJson(json.decode(str));

String ventaResponseToJson(VentaResponse data) => json.encode(data.toJson());

class VentaResponse {
  int statusCode;
  String message;
  Data data;

  VentaResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory VentaResponse.fromJson(Map<String, dynamic> json) => VentaResponse(
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
  Sale sale;
  String details;

  Data({
    required this.sale,
    required this.details,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        sale: Sale.fromJson(json["sale"]),
        details: json["details"],
      );

  Map<String, dynamic> toJson() => {
        "sale": sale.toJson(),
        "details": details,
      };
}

class Sale {
  int id;
  String total;
  String pay;
  String change;
  dynamic nitClient;
  bool status;
  int atmId;
  String client;
  String state;
  String statePay;
  DateTime createdAt;
  DateTime updatedAt;
  int tenantId;

  Sale({
    required this.id,
    required this.total,
    required this.pay,
    required this.change,
    required this.nitClient,
    required this.status,
    required this.atmId,
    required this.client,
    required this.state,
    required this.statePay,
    required this.createdAt,
    required this.updatedAt,
    required this.tenantId,
  });

  factory Sale.fromJson(Map<String, dynamic> json) => Sale(
        id: json["id"],
        total: json["total"],
        pay: json["pay"],
        change: json["change"],
        nitClient: json["nitClient"],
        status: json["status"],
        atmId: json["atmId"],
        client: json["client"],
        state: json["state"],
        statePay: json["statePay"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        tenantId: json["tenantId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "total": total,
        "pay": pay,
        "change": change,
        "nitClient": nitClient,
        "status": status,
        "atmId": atmId,
        "client": client,
        "state": state,
        "statePay": statePay,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "tenantId": tenantId,
      };
}
