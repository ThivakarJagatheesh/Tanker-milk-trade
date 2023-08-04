// To parse this JSON data, do
//

import 'dart:convert';

ShellBuyModel shellBuyModelFromJson(String str) =>
    ShellBuyModel.fromJson(json.decode(str));

String shellBuyModelToJson(ShellBuyModel data) => json.encode(data.toJson());

class ShellBuyModel {
  List<ShellBuyBody>? body;

  ShellBuyModel({
    this.body,
  });

  factory ShellBuyModel.fromJson(Map<String, dynamic> json) => ShellBuyModel(
        body: json["body"] == null
            ? []
            : List<ShellBuyBody>.from(
                json["body"]!.map((x) => ShellBuyBody.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "body": body == null
            ? []
            : List<dynamic>.from(body!.map((x) => x.toJson())),
      };
}

class ShellBuyBody {
  String? userId;
  dynamic firstName;
  dynamic lastName;
  dynamic email;
  dynamic mobile;
  String? productType;
  String? milkType;
  String? productTypeId;
  dynamic productTypeName;
  String? subProducttypeId;
  String? subProducttypeName;
  String? avaiablequanitity;
  String? fat;
  String? mbrt;
  String? ageOfMilk;
  String? snf;
  String? labreportFile;
  String? productName;
  String? prductImage;
  String? price;
  DateTime? postCreatedDateTime;
  DateTime? postExpiredDateTime;
  String? postType;

  ShellBuyBody({
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.mobile,this.productType,this.milkType,
    this.productTypeId,
    this.productTypeName,
    this.subProducttypeId,
    this.subProducttypeName,
    this.avaiablequanitity,
    this.fat,
    this.mbrt,
    this.ageOfMilk,
    this.snf,
    this.labreportFile,
    this.productName,
    this.prductImage,
    this.price,
    this.postCreatedDateTime,
    this.postExpiredDateTime,
    this.postType,
  });

  factory ShellBuyBody.fromJson(Map<String, dynamic> json) => ShellBuyBody(
        userId: json["userID"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        mobile: json["mobile"],
        productTypeId: json["productTypeID"],
        productTypeName: json["productTypeName"],
        subProducttypeId: json["subProducttypeID"],
        subProducttypeName: json["subProducttypeName"],
        avaiablequanitity: json["avaiablequanitity"],
        fat: json["FAT"],
        mbrt: json["MBRT"],
        ageOfMilk: json["ageOfMilk"],
        snf: json["SNF"],
        labreportFile: json["labreportFile"],
        productName: json["productName"],
        prductImage: json["prductImage"],
        price: json["price"],
        postCreatedDateTime: json["postCreatedDateTime"] == null
            ? null
            : DateTime.parse(json["postCreatedDateTime"]),
        postExpiredDateTime: json["postExpiredDateTime"] == null
            ? null
            : DateTime.parse(json["postExpiredDateTime"]),
        postType: json["postType"],
      );

  Map<String, dynamic> toJson() => {
        "userID": userId,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "mobile": mobile,
        "productTypeID": productTypeId,
        "productTypeName": productTypeName,
        "subProducttypeID": subProducttypeId,
        "subProducttypeName": subProducttypeName,
        "avaiablequanitity": avaiablequanitity,
        "FAT": fat,
        "MBRT": mbrt,
        "ageOfMilk": ageOfMilk,
        "SNF": snf,
        "labreportFile": labreportFile,
        "productName": productName,
        "prductImage": prductImage,
        "price": price,
        "postCreatedDateTime": postCreatedDateTime?.toIso8601String(),
        "postExpiredDateTime": postExpiredDateTime?.toIso8601String(),
        "postType": postType,
      };
}
