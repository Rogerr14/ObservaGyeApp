// To parse this JSON data, do
//
//     final alertsModel = alertsModelFromJson(jsonString);

import 'dart:convert';

AlertsModel alertsModelFromJson(String str) => AlertsModel.fromJson(json.decode(str));

String alertsModelToJson(AlertsModel data) => json.encode(data.toJson());

class AlertsModel {
    List<Alerta> alertas;

    AlertsModel({
        required this.alertas,
    });

    factory AlertsModel.fromJson(Map<String, dynamic> json) => AlertsModel(
        alertas: List<Alerta>.from(json["alertas"].map((x) => Alerta.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "alertas": List<dynamic>.from(alertas.map((x) => x.toJson())),
    };
}

class Alerta {
    String idAlerta;
    String tipoAlerta;
    int nivelPrioridad;
    String iconoAlerta;
    String usuario;
    String nombreSendero;
    String nombreEstado;
    String coordenadaLongitud;
    String coordenadaLatitud;
    String imagen1;
    String imagen2;
    String imagen3;
    String descripcion;
    DateTime fechaCreado;
    String idEstado;

    Alerta({
        required this.idAlerta,
        required this.tipoAlerta,
        required this.nivelPrioridad,
         this.iconoAlerta = '',
        required this.usuario,
        required this.nombreSendero,
        required this.nombreEstado,
        required this.coordenadaLongitud,
        required this.coordenadaLatitud,
        required this.imagen1,
         this.imagen2 ='',
         this.imagen3='',
        required this.descripcion,
        required this.fechaCreado,
        required this.idEstado,
    });

    factory Alerta.fromJson(Map<String, dynamic> json) => Alerta(
        idAlerta: json["id_alerta"],
        tipoAlerta: json["tipo_alerta"],
        nivelPrioridad: json["nivel_prioridad"],
        iconoAlerta: json["icono_alerta"]??'',
        usuario: json["usuario"],
        nombreSendero: json["nombre_sendero"],
        nombreEstado: json["nombre_estado"],
        coordenadaLongitud: json["coordenada_longitud"],
        coordenadaLatitud: json["coordenada_latitud"],
        imagen1: json["imagen_1"],
        imagen2: json["imagen_2"]??'',
        imagen3: json["imagen_3"]??'',
        descripcion: json["descripcion"],
        fechaCreado: DateTime.parse(json["fecha_creado"]),
        idEstado: json["id_estado"],
    );

    Map<String, dynamic> toJson() => {
        "id_alerta": idAlerta,
        "tipo_alerta": tipoAlerta,
        "nivel_prioridad": nivelPrioridad,
        "icono_alerta": iconoAlerta,
        "usuario": usuario,
        "nombre_sendero": nombreSendero,
        "nombre_estado": nombreEstado,
        "coordenada_longitud": coordenadaLongitud,
        "coordenada_latitud": coordenadaLatitud,
        "imagen_1": imagen1,
        "imagen_2": imagen2,
        "imagen_3": imagen3,
        "descripcion": descripcion,
        "fecha_creado": fechaCreado.toIso8601String(),
        "id_estado": idEstado,
    };
}
