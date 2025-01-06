// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    final String idUser;
    final String name;
    final String lastName;
    final String email;
    final String phone;
    final String photo;
    final String token;

    UserModel({
        required this.idUser,
        required this.name,
        required this.lastName,
        required this.email,
        required this.phone,
        this.photo = '',
        required this.token,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        idUser: json["id_user"],
        name: json["name"],
        lastName: json["lastName"],
        email: json["email"],
        phone: json["phone"],
        photo: json["photo"] ?? '',
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "id_user": idUser,
        "name": name,
        "lastName": lastName,
        "email": email,
        "phone": phone,
        "photo": photo ,
        "token": token,
    };
}
