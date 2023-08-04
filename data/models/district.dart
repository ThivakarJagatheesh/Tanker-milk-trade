// To parse this JSON data, do
//
//     final districtModel = districtModelFromJson(jsonString);

import 'dart:convert';

DistrictModel districtModelFromJson(String str) => DistrictModel.fromJson(json.decode(str));

String districtModelToJson(DistrictModel data) => json.encode(data.toJson());

class DistrictModel {
    List<DistrictBody>? body;

    DistrictModel({
        this.body,
    });

    factory DistrictModel.fromJson(Map<String, dynamic> json) => DistrictModel(
        body: List<DistrictBody>.from(json["body"].map((x) => DistrictBody.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "body": List<dynamic>.from(body!.map((x) => x.toJson())),
    };
}

class DistrictBody {
    dynamic stateName;
    String? districtCode;
    String? stateId;

    DistrictBody({
        this.stateName,
        this.districtCode,
        this.stateId,
    });

    factory DistrictBody.fromJson(Map<String, dynamic> json) => DistrictBody(
        stateName: json["stateName"],
        districtCode: json["districtCode"],
        stateId: json["stateID"],
    );

    Map<String, dynamic> toJson() => {
        "stateName": stateName,
        "districtCode": districtCode,
        "stateID": stateId,
    };
}
