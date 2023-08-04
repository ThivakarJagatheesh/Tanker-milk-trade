import 'dart:convert';

import 'package:dairy_products/common/widgets/local_storage/shared_storage.dart';
import 'package:dairy_products/data/api_client/api_client.dart';
import 'package:dairy_products/data/api_config/api_config.dart';
import 'package:dairy_products/data/models/gender.dart';
import 'package:dairy_products/data/models/login_resonse.dart';
import 'package:dairy_products/data/models/signup.dart';
import 'package:dio/dio.dart';

abstract class AuthenticationDataSource {
  Future<LoginResponse> loginTanker(
      {required String email, required String password});
  Future<dynamic> signupTanker(SignupModel signupModel);
  Future<dynamic> genderTanker();
}

class AuthenticationDataSourceImpl extends AuthenticationDataSource {
  final ApiClient apiClient;
  AuthenticationDataSourceImpl(this.apiClient);
  @override
  Future genderTanker() async {
    final response = await apiClient.getMethod(
      path: "gender.php",
    );
    if (response != null) {
      GenderModel genderModel = GenderModel.fromJson(json.decode(response));
      return genderModel;
    }
  }

  @override
  Future<LoginResponse> loginTanker(
      {required String email, required String password}) async {
    String url = ApiConfig.baseUrl;
    Map<String, dynamic> params = {
      "datavalue": MultipartFile.fromString(
          jsonEncode({"email": email, "password": password}))
    };
    final formData = FormData.fromMap(params);
    var params1 = {
      "Content-Type": "multipart/form-data",
      'Accept': 'application/json',
    };
    final response = await apiClient.postMethod(
        path: "${url}login.php", params: formData, params1: params1);
   
    LoginResponse loginResponse = LoginResponse.fromJson(response);
    
    await SharedStorage.setString(
        ApiConfig.userId, loginResponse.body!.userId!);
    return loginResponse;
  }

  @override
  Future signupTanker(SignupModel signupModel) async {
    String url = ApiConfig.baseUrl;
    Map<String, dynamic> params = {
      "datavalue": MultipartFile.fromString(jsonEncode({
        "firstname": signupModel.firstname,
        "lastname": "dravid",
        "gender": "Male",
        "DOB": "11/09/2020",
        "email": signupModel.email, // "test@test.com1"
        "mobilenumber": signupModel.mobilenumber,
        "password": signupModel.password
      }))
    };
    final formData = FormData.fromMap(params);

    final response =
        await apiClient.postMethod(path: "${url}signup.php", params: formData);
    if (response != null) {
      await SharedStorage.setString("firstName", signupModel.firstname!);
      await SharedStorage.setString("designation", signupModel.lastname!);
      await SharedStorage.setString("email", signupModel.email!);
      await SharedStorage.setString("phone", signupModel.mobilenumber!);
      await SharedStorage.setString("role", signupModel.dob!);
      SignupModel signupModels = SignupModel.fromJson(response);
      return signupModels;
    }
  }
}
