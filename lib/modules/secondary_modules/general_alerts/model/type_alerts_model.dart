// To parse this JSON data, do
//
//     final typeAlertsModel = typeAlertsModelFromJson(jsonString);

import 'dart:convert';

TypeAlertsModel typeAlertsModelFromJson(String str) => TypeAlertsModel.fromJson(json.decode(str));

String typeAlertsModelToJson(TypeAlertsModel data) => json.encode(data.toJson());

class TypeAlertsModel {
    List<TiposAlerta> tiposAlertas;
    List<Sendero> senderos;

    TypeAlertsModel({
        required this.tiposAlertas,
        required this.senderos,
    });

    factory TypeAlertsModel.fromJson(Map<String, dynamic> json) => TypeAlertsModel(
        tiposAlertas: List<TiposAlerta>.from(json["tipos_alertas"].map((x) => TiposAlerta.fromJson(x))),
        senderos: List<Sendero>.from(json["senderos"].map((x) => Sendero.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "tipos_alertas": List<dynamic>.from(tiposAlertas.map((x) => x.toJson())),
        "senderos": List<dynamic>.from(senderos.map((x) => x.toJson())),
    };
}

class Sendero {
    String idSendero;
    String idOrganizacion;
    String nombreSendero;

    Sendero({
        required this.idSendero,
        required this.idOrganizacion,
        required this.nombreSendero,
    });

    factory Sendero.fromJson(Map<String, dynamic> json) => Sendero(
        idSendero: json["id_sendero"],
        idOrganizacion: json["id_organizacion"],
        nombreSendero: json["nombre_sendero"],
    );

    Map<String, dynamic> toJson() => {
        "id_sendero": idSendero,
        "id_organizacion": idOrganizacion,
        "nombre_sendero": nombreSendero,
    };
}

class TiposAlerta {
    String idTipoAlerta;
    String tipoAlerta;
    int nivelPrioridad;
    String iconoAlerta;

    TiposAlerta({
        required this.idTipoAlerta,
        required this.tipoAlerta,
        required this.nivelPrioridad,
        required this.iconoAlerta,
    });

    factory TiposAlerta.fromJson(Map<String, dynamic> json) => TiposAlerta(
        idTipoAlerta: json["id_tipo_alerta"],
        tipoAlerta: json["tipo_alerta"],
        nivelPrioridad: json["nivel_prioridad"],
        iconoAlerta: json["icono_alerta"],
    );

    Map<String, dynamic> toJson() => {
        "id_tipo_alerta": idTipoAlerta,
        "tipo_alerta": tipoAlerta,
        "nivel_prioridad": nivelPrioridad,
        "icono_alerta": iconoAlerta,
    };
}
