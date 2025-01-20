// To parse this JSON data, do
//
//     final listEspecies = listEspeciesFromJson(jsonString);

import 'dart:convert';
import 'dart:ffi';

ListEspecies listEspeciesFromJson(String str) => ListEspecies.fromJson(json.decode(str));

String listEspeciesToJson(ListEspecies data) => json.encode(data.toJson());

class ListEspecies {
    List<Especy> especies;

    ListEspecies({
        required this.especies,
    });

    factory ListEspecies.fromJson(Map<String, dynamic> json) => ListEspecies(
        especies: List<Especy>.from(json["especies"].map((x) => Especy.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "especies": List<dynamic>.from(especies.map((x) => x.toJson())),
    };
}

class Especy {
    int idEspecie;
    String nombreComun;
    String nombreCientifico;
    NombreCategoria nombreCategoria;
    String imagen;

    Especy({
        required this.idEspecie,
        required this.nombreComun,
        required this.nombreCientifico,
        required this.nombreCategoria,
        required this.imagen,
    });

    factory Especy.fromJson(Map<String, dynamic> json) => Especy(
        idEspecie: json["id_especie"],
        nombreComun: json["nombre_comun"],
        nombreCientifico: json["nombre_cientifico"],
        nombreCategoria: nombreCategoriaValues.map[json["nombre_categoria"]]!,
        imagen: json["imagen"],
    );

    Map<String, dynamic> toJson() => {
        "id_especie": idEspecie,
        "nombre_comun": nombreComun,
        "nombre_cientifico": nombreCientifico,
        "nombre_categoria": nombreCategoriaValues.reverse[nombreCategoria],
        "imagen": imagen,
    };
}

enum NombreCategoria {
    ANFIBIOS,
    AVES,
    INSECTOS,
    MAMFEROS,
    REPTILES
}

final nombreCategoriaValues = EnumValues({
    "Anfibios": NombreCategoria.ANFIBIOS,
    "Aves": NombreCategoria.AVES,
    "Insectos": NombreCategoria.INSECTOS,
    "Mamíferos": NombreCategoria.MAMFEROS,
    "Reptiles": NombreCategoria.REPTILES
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
