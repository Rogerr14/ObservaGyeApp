// To parse this JSON data, do
//
//     final typeAlertsModel = typeAlertsModelFromJson(jsonString);

import 'dart:convert';

TypeAlertsModel typeAlertsModelFromJson(String str) => TypeAlertsModel.fromJson(json.decode(str));

String typeAlertsModelToJson(TypeAlertsModel data) => json.encode(data.toJson());

class TypeAlertsModel {
    List<TiposAlerta> tiposAlertas;

    TypeAlertsModel({
        required this.tiposAlertas,
    });

    factory TypeAlertsModel.fromJson(Map<String, dynamic> json) => TypeAlertsModel(
        tiposAlertas: List<TiposAlerta>.from(json["tipos_alertas"].map((x) => TiposAlerta.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "tipos_alertas": List<dynamic>.from(tiposAlertas.map((x) => x.toJson())),
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
