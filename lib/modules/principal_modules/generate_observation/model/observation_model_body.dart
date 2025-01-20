// To parse this JSON data, do
//
//     final observationModelBody = observationModelBodyFromJson(jsonString);

import 'dart:convert';

ObservationModelBody observationModelBodyFromJson(String str) => ObservationModelBody.fromJson(json.decode(str));

String observationModelBodyToJson(ObservationModelBody data) => json.encode(data.toJson());

class ObservationModelBody {
    int idEspecie;
    int idSendero;
    String descripcion;
    String fechaObservacion;
    double coordenadaLongitud;
    double coordenadaLatitud;
    bool estado;

    ObservationModelBody({
        required this.idEspecie,
        required this.idSendero,
        required this.descripcion,
        required this.fechaObservacion,
        required this.coordenadaLongitud,
        required this.coordenadaLatitud,
        required this.estado,
    });

    factory ObservationModelBody.fromJson(Map<String, dynamic> json) => ObservationModelBody(
        idEspecie: json["id_especie"],
        idSendero: json["id_sendero"],
        descripcion: json["descripcion"],
        fechaObservacion: json["fecha_observacion"],
        coordenadaLongitud: json["coordenada_longitud"]?.toDouble(),
        coordenadaLatitud: json["coordenada_latitud"]?.toDouble(),
        estado: json["estado"],
    );

    Map<String, dynamic> toJson() => {
        "id_especie": idEspecie,
        "id_sendero": idSendero,
        "descripcion": descripcion,
        "fecha_observacion": fechaObservacion,
        "coordenada_longitud": coordenadaLongitud,
        "coordenada_latitud": coordenadaLatitud,
        "estado": estado,
    };
}
