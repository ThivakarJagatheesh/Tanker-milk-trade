// To parse this JSON data, do
//
//     final stateModel = stateModelFromJson(jsonString);

import 'dart:convert';

StateModel stateModelFromJson(String str) => StateModel.fromJson(json.decode(str));

String stateModelToJson(StateModel data) => json.encode(data.toJson());

class StateModel {
    List<Statebody>? statebody;

    StateModel({
        this.statebody,
    });

    factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
        statebody: List<Statebody>.from(json["body"].map((x) => Statebody.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "body": List<dynamic>.from(statebody!.map((x) => x.toJson())),
    };
}

class Statebody {
    String? stateName;
    String? stateCode;
    String? country;

    Statebody({
        this.stateName,
        this.stateCode,
        this.country,
    });

    factory Statebody.fromJson(Map<String, dynamic> json) => Statebody(
        stateName: json["stateName"],
        stateCode: json["stateCode"],
        country: json["Country"],
    );

    Map<String, dynamic> toJson() => {
        "stateName": stateName,
        "stateCode": stateCode,
        "Country": country,
    };
}
