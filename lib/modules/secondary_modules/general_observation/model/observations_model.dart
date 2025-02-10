// To parse this JSON data, do
//
//     final observations = observationsFromJson(jsonString);

import 'dart:convert';

Observations observationsFromJson(String str) => Observations.fromJson(json.decode(str));

String observationsToJson(Observations data) => json.encode(data.toJson());

class Observations {
    List<Observaciones> observaciones;

    Observations({
        required this.observaciones,
    });

    factory Observations.fromJson(Map<String, dynamic> json) => Observations(
        observaciones: List<Observaciones>.from(json["observaciones"].map((x) => Observaciones.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "observaciones": List<dynamic>.from(observaciones.map((x) => x.toJson())),
    };
}

class Observaciones {
    String idObservacion;
    String idEspecie;
    dynamic nombreTemporal;
    String nombreComun;
    String nombreCientifico;
    String nombreCategoria;
    String idUsuario;
    String usuario;
    String idSendero;
    String nombreSendero;
    String descripcion;
    DateTime fechaObservacion;
    String coordenadaLongitud;
    String coordenadaLatitud;
    String idEstado;
    String nombreEstado;
    String imagen1;
    dynamic imagen2;
    dynamic imagen3;
    DateTime fechaCreado;

    Observaciones({
        required this.idObservacion,
        required this.idEspecie,
        required this.nombreTemporal,
        required this.nombreComun,
        required this.nombreCientifico,
        required this.nombreCategoria,
        required this.idUsuario,
        required this.usuario,
        required this.idSendero,
        required this.nombreSendero,
        required this.descripcion,
        required this.fechaObservacion,
        required this.coordenadaLongitud,
        required this.coordenadaLatitud,
        required this.idEstado,
        required this.nombreEstado,
        required this.imagen1,
        required this.imagen2,
        required this.imagen3,
        required this.fechaCreado,
    });

    factory Observaciones.fromJson(Map<String, dynamic> json) => Observaciones(
        idObservacion: json["id_observacion"],
        idEspecie: json["id_especie"],
        nombreTemporal: json["nombre_temporal"],
        nombreComun: json["nombre_comun"],
        nombreCientifico: json["nombre_cientifico"],
        nombreCategoria: json["nombre_categoria"],
        idUsuario: json["id_usuario"],
        usuario: json["usuario"],
        idSendero: json["id_sendero"],
        nombreSendero: json["nombre_sendero"],
        descripcion: json["descripcion"],
        fechaObservacion: DateTime.parse(json["fecha_observacion"]),
        coordenadaLongitud: json["coordenada_longitud"],
        coordenadaLatitud: json["coordenada_latitud"],
        idEstado: json["id_estado"],
        nombreEstado: json["nombre_estado"],
        imagen1: json["imagen_1"],
        imagen2: json["imagen_2"],
        imagen3: json["imagen_3"],
        fechaCreado: DateTime.parse(json["fecha_creado"]),
    );

    Map<String, dynamic> toJson() => {
        "id_observacion": idObservacion,
        "id_especie": idEspecie,
        "nombre_temporal": nombreTemporal,
        "nombre_comun": nombreComun,
        "nombre_cientifico": nombreCientifico,
        "nombre_categoria": nombreCategoria,
        "id_usuario": idUsuario,
        "usuario": usuario,
        "id_sendero": idSendero,
        "nombre_sendero": nombreSendero,
        "descripcion": descripcion,
        "fecha_observacion": fechaObservacion.toIso8601String(),
        "coordenada_longitud": coordenadaLongitud,
        "coordenada_latitud": coordenadaLatitud,
        "id_estado": idEstado,
        "nombre_estado": nombreEstado,
        "imagen_1": imagen1,
        "imagen_2": imagen2,
        "imagen_3": imagen3,
        "fecha_creado": fechaCreado.toIso8601String(),
    };
}
