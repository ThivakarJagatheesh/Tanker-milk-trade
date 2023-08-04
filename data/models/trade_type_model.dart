// To parse this JSON data, do
//
//     final tradeTypeModel = tradeTypeModelFromJson(jsonString);

import 'dart:convert';

TradeTypeModel tradeTypeModelFromJson(String str) => TradeTypeModel.fromJson(json.decode(str));

String tradeTypeModelToJson(TradeTypeModel data) => json.encode(data.toJson());

class TradeTypeModel {
    List<TradeTypeBody>? body;

    TradeTypeModel({
        this.body,
    });

    factory TradeTypeModel.fromJson(Map<String, dynamic> json) => TradeTypeModel(
        body: json["body"] == null ? [] : List<TradeTypeBody>.from(json["body"]!.map((x) => TradeTypeBody.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "body": body == null ? [] : List<dynamic>.from(body!.map((x) => x.toJson())),
    };
}

class TradeTypeBody {
    String? typeName;
    String? tradtypeCode;

    TradeTypeBody({
        this.typeName,
        this.tradtypeCode,
    });

    factory TradeTypeBody.fromJson(Map<String, dynamic> json) => TradeTypeBody(
        typeName: json["typeName"],
        tradtypeCode: json["tradtypeCode"],
    );

    Map<String, dynamic> toJson() => {
        "typeName": typeName,
        "tradtypeCode": tradtypeCode,
    };
}
