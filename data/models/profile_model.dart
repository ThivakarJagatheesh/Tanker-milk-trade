// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
    List<ProfileBody>? body;

    ProfileModel({
        this.body,
    });

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        body: json["body"] == null ? [] : List<ProfileBody>.from(json["body"]!.map((x) => ProfileBody.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "body": body == null ? [] : List<dynamic>.from(body!.map((x) => x.toJson())),
    };
}

class ProfileBody {
    UserInfo? userInfo;
    TradeInfo? tradeInfo;

    ProfileBody({
        this.userInfo,
        this.tradeInfo,
    });

    factory ProfileBody.fromJson(Map<String, dynamic> json) => ProfileBody(
        userInfo: json["userInfo"] == null ? null : UserInfo.fromJson(json["userInfo"]),
        tradeInfo: json["tradeInfo"] == null ? null : TradeInfo.fromJson(json["tradeInfo"]),
    );

    Map<String, dynamic> toJson() => {
        "userInfo": userInfo?.toJson(),
        "tradeInfo": tradeInfo?.toJson(),
    };
}

class TradeInfo {
    String? tradeName;
    String? tradeLogo;
    String? natureId;
    String? natureName;
    String? gst;
    String? fssai;
    String? pin;
    String? stateId;
    String? stateName;
    String? districtId;
    String? districtName;
    String? address;
    String? tradeEmail;
    String? tradeContactNumber;
    String? tradeTypeCode;
    String? tradeTypeName;
    String? location;

    TradeInfo({
        this.tradeName,
        this.tradeLogo,
        this.natureId,
        this.natureName,
        this.gst,
        this.fssai,
        this.pin,
        this.stateId,
        this.stateName,
        this.districtId,
        this.districtName,
        this.address,
        this.tradeEmail,
        this.tradeContactNumber,
        this.tradeTypeCode,
        this.tradeTypeName,
        this.location,
    });

    factory TradeInfo.fromJson(Map<String, dynamic> json) => TradeInfo(
        tradeName: json["tradeName"],
        tradeLogo: json["tradeLogo"],
        natureId: json["natureID"],
        natureName: json["natureName"],
        gst: json["GST"],
        fssai: json["fssai"],
        pin: json["pin"],
        stateId: json["stateID"],
        stateName: json["stateName"],
        districtId: json["districtID"],
        districtName: json["districtName"],
        address: json["address"],
        tradeEmail: json["tradeEmail"],
        tradeContactNumber: json["tradeContactNumber"],
        tradeTypeCode: json["TradeTypeCode"],
        tradeTypeName: json["TradeTypeName"],
        location: json["location"],
    );

    Map<String, dynamic> toJson() => {
        "tradeName": tradeName,
        "tradeLogo": tradeLogo,
        "natureID": natureId,
        "natureName": natureName,
        "GST": gst,
        "fssai": fssai,
        "pin": pin,
        "stateID": stateId,
        "stateName": stateName,
        "districtID": districtId,
        "districtName": districtName,
        "address": address,
        "tradeEmail": tradeEmail,
        "tradeContactNumber": tradeContactNumber,
        "TradeTypeCode": tradeTypeCode,
        "TradeTypeName": tradeTypeName,
        "location": location,
    };
}

class UserInfo {
    String? userId;
    String? firstName;
    String? lastName;
    String? email;
    String? mobile;
    String? profile;

    UserInfo({
        this.userId,
        this.firstName,
        this.lastName,
        this.email,
        this.mobile,
        this.profile,
    });

    factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        userId: json["userID"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        mobile: json["mobile"],
        profile: json["profile"],
    );

    Map<String, dynamic> toJson() => {
        "userID": userId,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "mobile": mobile,
        "profile": profile,
    };
}
