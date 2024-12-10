// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
    final Usuario usuario;
    final String sessionToken;

    LoginResponse({
        required this.usuario,
        required this.sessionToken,
    });

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        usuario: Usuario.fromJson(json["usuario"]),
        sessionToken: json["sessionToken"],
    );

    Map<String, dynamic> toJson() => {
        "usuario": usuario.toJson(),
        "sessionToken": sessionToken,
    };
}

class Usuario {
    final String idUsuario;
    final String idRol;
    final String nombres;
    final String apellidos;
    final String correo;
    final String password;
    final String telefono;
    final dynamic imagen;
    final dynamic sessionToken;
    final DateTime fechaCreado;
    final DateTime fechaModificado;
    final String nombreRol;

    Usuario({
        required this.idUsuario,
        required this.idRol,
        required this.nombres,
        required this.apellidos,
        required this.correo,
        required this.password,
        required this.telefono,
        required this.imagen,
        required this.sessionToken,
        required this.fechaCreado,
        required this.fechaModificado,
        required this.nombreRol,
    });

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        idUsuario: json["id_usuario"],
        idRol: json["id_rol"],
        nombres: json["nombres"],
        apellidos: json["apellidos"],
        correo: json["correo"],
        password: json["password"],
        telefono: json["telefono"],
        imagen: json["imagen"],
        sessionToken: json["session_token"],
        fechaCreado: DateTime.parse(json["fecha_creado"]),
        fechaModificado: DateTime.parse(json["fecha_modificado"]),
        nombreRol: json["nombre_rol"],
    );

    Map<String, dynamic> toJson() => {
        "id_usuario": idUsuario,
        "id_rol": idRol,
        "nombres": nombres,
        "apellidos": apellidos,
        "correo": correo,
        "password": password,
        "telefono": telefono,
        "imagen": imagen,
        "session_token": sessionToken,
        "fecha_creado": fechaCreado.toIso8601String(),
        "fecha_modificado": fechaModificado.toIso8601String(),
        "nombre_rol": nombreRol,
    };
}
