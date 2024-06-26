// To parse this JSON data, do
//
//     final authTenantResponse = authTenantResponseFromJson(jsonString);

import 'dart:convert';

AuthTenantResponse authTenantResponseFromJson(String str) =>
    AuthTenantResponse.fromJson(json.decode(str));

String authTenantResponseToJson(AuthTenantResponse data) =>
    json.encode(data.toJson());

class AuthTenantResponse {
  String message;
  int statusCode;
  Data data;

  AuthTenantResponse({
    required this.message,
    required this.statusCode,
    required this.data,
  });

  factory AuthTenantResponse.fromJson(Map<String, dynamic> json) =>
      AuthTenantResponse(
        message: json["message"],
        statusCode: json["statusCode"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "statusCode": statusCode,
        "data": data.toJson(),
      };
}

class Data {
  User user;
  String token;
  MemberRole memberRole;

  Data({
    required this.user,
    required this.token,
    required this.memberRole,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json["user"]),
        token: json["token"],
        memberRole: MemberRole.fromJson(json["memberRole"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "token": token,
        "memberRole": memberRole.toJson(),
      };
}

class MemberRole {
  int id;
  String userId;
  String passwordTenant;
  Rol rol;

  MemberRole({
    required this.id,
    required this.userId,
    required this.passwordTenant,
    required this.rol,
  });

  factory MemberRole.fromJson(Map<String, dynamic> json) => MemberRole(
        id: json["id"],
        userId: json["userId"],
        passwordTenant: json["passwordTenant"],
        rol: Rol.fromJson(json["rol"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "passwordTenant": passwordTenant,
        "rol": rol.toJson(),
      };
}

class Rol {
  int id;
  String desc;
  bool status;
  List<PermissionElement> permissions;

  Rol({
    required this.id,
    required this.desc,
    required this.status,
    required this.permissions,
  });

  factory Rol.fromJson(Map<String, dynamic> json) => Rol(
        id: json["id"],
        desc: json["desc"],
        status: json["status"],
        permissions: List<PermissionElement>.from(
            json["permissions"].map((x) => PermissionElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "desc": desc,
        "status": status,
        "permissions": List<dynamic>.from(permissions.map((x) => x.toJson())),
      };
}

class PermissionElement {
  PermissionPermission permission;

  PermissionElement({
    required this.permission,
  });

  factory PermissionElement.fromJson(Map<String, dynamic> json) =>
      PermissionElement(
        permission: PermissionPermission.fromJson(json["permission"]),
      );

  Map<String, dynamic> toJson() => {
        "permission": permission.toJson(),
      };
}

class PermissionPermission {
  String desc;
  int id;
  String module;

  PermissionPermission({
    required this.desc,
    required this.id,
    required this.module,
  });

  factory PermissionPermission.fromJson(Map<String, dynamic> json) =>
      PermissionPermission(
        desc: json["desc"],
        id: json["id"],
        module: json["module"],
      );

  Map<String, dynamic> toJson() => {
        "desc": desc,
        "id": id,
        "module": module,
      };
}

class User {
  String id;
  String email;
  String password;
  String name;
  String phone;
  dynamic photo;
  bool status;
  DateTime createdAt;
  DateTime updatedAt;

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
    required this.photo,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        password: json["password"],
        name: json["name"],
        phone: json["phone"],
        photo: json["photo"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "password": password,
        "name": name,
        "phone": phone,
        "photo": photo,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
