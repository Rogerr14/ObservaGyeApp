// To parse this JSON data, do
//
//     final alertData = alertDataFromJson(jsonString);

import 'dart:convert';

AlertData alertDataFromJson(String str) => AlertData.fromJson(json.decode(str));

String alertDataToJson(AlertData data) => json.encode(data.toJson());

class AlertData {
    int idTipoAlerta;
    int idSendero;
    double coordenadaLongitud;
    double coordenadaLatitud;
    String descripcion;
    DateTime fechaCreado;

    AlertData({
        required this.idTipoAlerta,
        required this.idSendero,
        required this.coordenadaLongitud,
        required this.coordenadaLatitud,
        required this.descripcion,
        required this.fechaCreado,
    });

    factory AlertData.fromJson(Map<String, dynamic> json) => AlertData(
        idTipoAlerta: json["id_tipo_alerta"],
        idSendero: json["id_sendero"],
        coordenadaLongitud: json["coordenada_longitud"]?.toDouble(),
        coordenadaLatitud: json["coordenada_latitud"]?.toDouble(),
        descripcion: json["descripcion"],
        fechaCreado: DateTime.parse(json["fecha_creado"]),
    );

    Map<String, dynamic> toJson() => {
        "id_tipo_alerta": idTipoAlerta,
        "id_sendero": idSendero,
        "coordenada_longitud": coordenadaLongitud,
        "coordenada_latitud": coordenadaLatitud,
        "descripcion": descripcion,
        "fecha_creado": "${fechaCreado.year.toString().padLeft(4, '0')}-${fechaCreado.month.toString().padLeft(2, '0')}-${fechaCreado.day.toString().padLeft(2, '0')}",
    };
}
