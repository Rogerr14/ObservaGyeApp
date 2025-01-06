// To parse this JSON data, do
//
//     final homeResponse = homeResponseFromJson(jsonString);

import 'dart:convert';

HomeResponse homeResponseFromJson(String str) => HomeResponse.fromJson(json.decode(str));

String homeResponseToJson(HomeResponse data) => json.encode(data.toJson());

class HomeResponse {
    List<Observation> observations;
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
        observations: List<Observation>.from(json["observations"].map((x) => Observation.fromJson(x))),
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

class Observation {
    int idObservation;
    String observationName;
    DateTime observationDate;
    String userName;
    String urlImage;

    Observation({
        required this.idObservation,
        required this.observationName,
        required this.observationDate,
        required this.userName,
        required this.urlImage,
    });

    factory Observation.fromJson(Map<String, dynamic> json) => Observation(
        idObservation: json["id_observation"],
        observationName: json["observation_name"],
        observationDate: DateTime.parse(json["observation_date"]),
        userName: json["user_name"],
        urlImage: json["url_image"],
    );

    Map<String, dynamic> toJson() => {
        "id_observation": idObservation,
        "observation_name": observationName,
        "observation_date": "${observationDate.year.toString().padLeft(4, '0')}-${observationDate.month.toString().padLeft(2, '0')}-${observationDate.day.toString().padLeft(2, '0')}",
        "user_name": userName,
        "url_image": urlImage,
    };
}
