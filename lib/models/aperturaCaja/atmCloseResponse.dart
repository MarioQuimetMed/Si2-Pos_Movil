// To parse this JSON data, do
//
//     final atmCloseResponse = atmCloseResponseFromJson(jsonString);

import 'dart:convert';

AtmCloseResponse atmCloseResponseFromJson(String str) =>
    AtmCloseResponse.fromJson(json.decode(str));

String atmCloseResponseToJson(AtmCloseResponse data) =>
    json.encode(data.toJson());

class AtmCloseResponse {
  int statusCode;
  String message;
  Data data;

  AtmCloseResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory AtmCloseResponse.fromJson(Map<String, dynamic> json) =>
      AtmCloseResponse(
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
