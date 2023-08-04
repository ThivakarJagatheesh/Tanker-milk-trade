// To parse this JSON data, do
//
//     final signupModel = signupModelFromJson(jsonString);

import 'dart:convert';

SignupModel signupModelFromJson(String str) => SignupModel.fromJson(json.decode(str));

String signupModelToJson(SignupModel data) => json.encode(data.toJson());

class SignupModel {
    SignupModel({
        this.firstname,
        this.lastname,
        this.gender,
        this.dob,
        this.email,
        this.mobilenumber,
        this.password,
    });

    String? firstname;
    String? lastname;
    String? gender;
    String? dob;
    String? email;
    String? mobilenumber;
    String? password;

    factory SignupModel.fromJson(Map<String, dynamic> json) => SignupModel(
        firstname: json["firstname"],
        lastname: json["lastname"],
        gender: json["gender"],
        dob: json["DOB"],
        email: json["email"],
        mobilenumber: json["mobilenumber"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "lastname": lastname,
        "gender": gender,
        "DOB": dob,
        "email": email,
        "mobilenumber": mobilenumber,
        "password": password,
    };
}
