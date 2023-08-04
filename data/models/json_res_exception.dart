// To parse this JSON data, do
//
//     final jsonResponseException = jsonResponseExceptionFromJson(jsonString);

import 'dart:convert';

JsonResponseException jsonResponseExceptionFromJson(String str) => JsonResponseException.fromJson(json.decode(str));

String jsonResponseExceptionToJson(JsonResponseException data) => json.encode(data.toJson());

class JsonResponseException {
    JsonResponseException({
        this.body,
    });

    Body? body;

    factory JsonResponseException.fromJson(Map<String, dynamic> json) => JsonResponseException(
        body: json["body"] == null ? null : Body.fromJson(json["body"]),
    );

    Map<String, dynamic> toJson() => {
        "body": body?.toJson(),
    };
}

class Body {
    Body({
        this.status,
        this.message,
    });

    String? status;
    String? message;

    factory Body.fromJson(Map<String, dynamic> json) => Body(
        status: json["status"],
        message: json["Message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "Message": message,
    };
}
