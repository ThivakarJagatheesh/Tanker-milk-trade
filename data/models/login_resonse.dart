// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
    LoginResponse({
        this.body,
    });

    LoginBody? body;

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        body: json["body"] == null ? null : LoginBody.fromJson(json["body"]),
    );

    Map<String, dynamic> toJson() => {
        "body": body?.toJson(),
    };
}

class LoginBody {
    LoginBody({
        this.status,
        this.message,
        this.userId,
    });

    String? status;
    String? message;
    String? userId;

    factory LoginBody.fromJson(Map<String, dynamic> json) => LoginBody(
        status: json["status"],
        message: json["Message"],
        userId: json["userId"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "Message": message,
        "userId": userId,
    };
}
