// To parse this JSON data, do
//
//     final genderModel = genderModelFromJson(jsonString);

import 'dart:convert';

GenderModel genderModelFromJson(String str) => GenderModel.fromJson(json.decode(str));

String genderModelToJson(GenderModel data) => json.encode(data.toJson());

class GenderModel {
    GenderModel({
        this.body,
    });

    List<GenderBody>? body;

    factory GenderModel.fromJson(Map<String, dynamic> json) => GenderModel(
        body: json["body"] == null ? [] : List<GenderBody>.from(json["body"]!.map((x) => GenderBody.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "body": body == null ? [] : List<dynamic>.from(body!.map((x) => x.toJson())),
    };
}

class GenderBody {
    GenderBody({
        this.genderName,
        this.genderCode,
    });

    String? genderName;
    String? genderCode;

    factory GenderBody.fromJson(Map<String, dynamic> json) => GenderBody(
        genderName: json["genderName"],
        genderCode: json["genderCode"],
    );

    Map<String, dynamic> toJson() => {
        "genderName": genderName,
        "genderCode": genderCode,
    };
}
