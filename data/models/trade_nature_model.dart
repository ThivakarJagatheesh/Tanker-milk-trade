// To parse this JSON data, do
//
//     final tradeNatureModel = tradeNatureModelFromJson(jsonString);

import 'dart:convert';

TradeNatureModel tradeNatureModelFromJson(String str) => TradeNatureModel.fromJson(json.decode(str));

String tradeNatureModelToJson(TradeNatureModel data) => json.encode(data.toJson());

class TradeNatureModel {
    List<TradeNatureBody>? body;

    TradeNatureModel({
        this.body,
    });

    factory TradeNatureModel.fromJson(Map<String, dynamic> json) => TradeNatureModel(
        body: json["body"] == null ? [] : List<TradeNatureBody>.from(json["body"]!.map((x) => TradeNatureBody.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "body": body == null ? [] : List<dynamic>.from(body!.map((x) => x.toJson())),
    };
}

class TradeNatureBody {
    String? tradeName;
    String? tradeCode;

    TradeNatureBody({
        this.tradeName,
        this.tradeCode,
    });

    factory TradeNatureBody.fromJson(Map<String, dynamic> json) => TradeNatureBody(
        tradeName: json["tradeName"],
        tradeCode: json["tradeCode"],
    );

    Map<String, dynamic> toJson() => {
        "tradeName": tradeName,
        "tradeCode": tradeCode,
    };
}
