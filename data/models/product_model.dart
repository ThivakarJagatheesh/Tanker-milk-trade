// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
    List<ProductBody>? body;

    ProductModel({
        this.body,
    });

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        body: json["body"] == null ? [] : List<ProductBody>.from(json["body"]!.map((x) => ProductBody.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "body": body == null ? [] : List<dynamic>.from(body!.map((x) => x.toJson())),
    };
}

class ProductBody {
    String? productTypeId;
    String? productTypeName;

    ProductBody({
        this.productTypeId,
        this.productTypeName,
    });

    factory ProductBody.fromJson(Map<String, dynamic> json) => ProductBody(
        productTypeId: json["productTypeID"],
        productTypeName: json["productTypeName"],
    );

    Map<String, dynamic> toJson() => {
        "productTypeID": productTypeId,
        "productTypeName": productTypeName,
    };
}
