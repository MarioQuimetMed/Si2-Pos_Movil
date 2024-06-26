// To parse this JSON data, do
//
//     final atmOpenResponse = atmOpenResponseFromJson(jsonString);

import 'dart:convert';

AtmOpenResponse atmOpenResponseFromJson(String str) =>
    AtmOpenResponse.fromJson(json.decode(str));

String atmOpenResponseToJson(AtmOpenResponse data) =>
    json.encode(data.toJson());

class AtmOpenResponse {
  int statusCode;
  String message;
  Data data;

  AtmOpenResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory AtmOpenResponse.fromJson(Map<String, dynamic> json) =>
      AtmOpenResponse(
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
  AtmControl atmControl;

  Data({
    required this.atmControl,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        atmControl: AtmControl.fromJson(json["atmControl"]),
      );

  Map<String, dynamic> toJson() => {
        "atmControl": atmControl.toJson(),
      };
}

class AtmControl {
  int id;
  String monto;
  String type;
  String employeeId;
  int atmId;
  DateTime time;

  AtmControl({
    required this.id,
    required this.monto,
    required this.type,
    required this.employeeId,
    required this.atmId,
    required this.time,
  });

  factory AtmControl.fromJson(Map<String, dynamic> json) => AtmControl(
        id: json["id"],
        monto: json["monto"],
        type: json["type"],
        employeeId: json["employeeId"],
        atmId: json["atmId"],
        time: DateTime.parse(json["time"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "monto": monto,
        "type": type,
        "employeeId": employeeId,
        "atmId": atmId,
        "time": time.toIso8601String(),
      };
}
