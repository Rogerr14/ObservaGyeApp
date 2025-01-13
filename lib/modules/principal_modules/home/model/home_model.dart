// To parse this JSON data, do
//
//     final homeResponse = homeResponseFromJson(jsonString);

import 'dart:convert';

import 'package:observa_gye_app/modules/secondary_modules/general_observation/model/observations_model.dart';

HomeResponse homeResponseFromJson(String str) => HomeResponse.fromJson(json.decode(str));

String homeResponseToJson(HomeResponse data) => json.encode(data.toJson());

class HomeResponse {
    List<Observaciones> observations;
    String totalObservation;
    String totalAlerts;
    String totalUsers;

    HomeResponse({
        required this.observations,
        required this.totalObservation,
        required this.totalAlerts,
        required this.totalUsers,
    });

    factory HomeResponse.fromJson(Map<String, dynamic> json) => HomeResponse(
        observations: List<Observaciones>.from(json["observations"].map((x) => Observaciones.fromJson(x))),
        totalObservation: json["totalObservation"],
        totalAlerts: json["totalAlerts"],
        totalUsers: json["totalUsers"],
    );

    Map<String, dynamic> toJson() => {
        "observations": List<dynamic>.from(observations.map((x) => x.toJson())),
        "totalObservation": totalObservation,
        "totalAlerts": totalAlerts,
        "totalUsers": totalUsers,
    };
}

