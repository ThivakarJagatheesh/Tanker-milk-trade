import 'dart:convert';

import 'package:dairy_products/common/widgets/local_storage/shared_storage.dart';
import 'package:dairy_products/data/api_client/api_client.dart';
import 'package:dairy_products/data/api_config/api_config.dart';
import 'package:dairy_products/data/models/district.dart';
import 'package:dairy_products/data/models/json_res_exception.dart';
import 'package:dairy_products/data/models/profile_model.dart';
import 'package:dairy_products/data/models/state.dart';
import 'package:dairy_products/data/models/trade_nature_model.dart';
import 'package:dairy_products/data/models/trade_type_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class ProfileTradeDataSource {
  Future<ProfileModel> getProfileList(int? userId);
  Future<TradeNatureModel> getTradeNature(String? tradeCode);
  Future<TradeTypeModel> getTradeType(String? tradeTypeCode);
  Future<dynamic> addTradeAccount(ProfileBody profileBody);
  Future<dynamic> updateTradeAndProfile(ProfileBody profileBody);
  Future<StateModel> stateList();
  Future<DistrictModel> districtList();
}

String url = ApiConfig.baseUrl;

class ProfileTradeDataSourceImpl extends ProfileTradeDataSource {
  final ApiClient client;
  ProfileTradeDataSourceImpl(this.client);
  @override
  Future addTradeAccount(ProfileBody profileBody) async {
    var dataValue = {
      "tradename": profileBody.tradeInfo!.tradeName,
      "nature": profileBody.tradeInfo!.natureName,
      "GST": profileBody.tradeInfo!.gst,
      "fssai": profileBody.tradeInfo!.fssai,
      "tradeEmail": profileBody.tradeInfo!.tradeEmail,
      "trademobile": profileBody.tradeInfo!.tradeContactNumber,
      "pin": profileBody.tradeInfo!.pin,
      "state": profileBody.tradeInfo!.stateId,
      "district": profileBody.tradeInfo!.districtId,
      "address": profileBody.tradeInfo!.address,
      "tradeType": profileBody.tradeInfo!.tradeTypeCode,
      "location":
          profileBody.tradeInfo?.location ?? 'location is not yet added',
      "userid": SharedStorage.getString(ApiConfig.userId)
    };
    Map<String, dynamic> params = {
      "datavalue": MultipartFile.fromString(jsonEncode(dataValue)),
    };

    debugPrint("params is a $dataValue");
    final formData = FormData.fromMap(params);
    final response =
        await client.postMethod(path: "${url}tradeinfo.php", params: formData);
    return response;
  }

  @override
  Future<ProfileModel> getProfileList(int? userId) async {
    Map<String, dynamic> params = {
      "userID": userId,
    };
    // final formData = FormData.fromMap(params);
    final response =
        await client.getMethod(path: "${url}profile.php", params: params);

    ProfileModel profileModel = ProfileModel.fromJson(response);
    return profileModel;
  }

  @override
  Future<TradeNatureModel> getTradeNature(String? tradeCode) async {
    Map<String, dynamic> params = {
      "tradeCode": MultipartFile.fromString(jsonEncode(tradeCode)),
    };
    // final formData = FormData.fromMap(params);
    final response = await client.getMethod(
        path: "${url}tradenature.php",
        params: tradeCode != null ? params : null);
    TradeNatureModel tradeNatureModel = TradeNatureModel.fromJson(response);
    return tradeNatureModel;
  }

  @override
  Future<TradeTypeModel> getTradeType(String? tradeTypeCode) async {
    Map<String, dynamic> params = {
      "tradtypeCode": MultipartFile.fromString(jsonEncode(tradeTypeCode)),
    };
    // final formData = FormData.fromMap(params);
    final response = await client.getMethod(
        path: "${url}tradeType.php",
        params: tradeTypeCode != null ? params : null);
    TradeTypeModel tradeTypeModel = TradeTypeModel.fromJson(response);
    return tradeTypeModel;
  }

  @override
  Future updateTradeAndProfile(ProfileBody profileBody) async {
    Map tradeDataValue = {};
    Map userDataValue = {};
    if (profileBody.tradeInfo != null) {
      tradeDataValue = {
        "tradename": profileBody.tradeInfo!.tradeName,
        "nature": profileBody.tradeInfo!.natureName,
        "GST": profileBody.tradeInfo!.gst,
        "fssai": profileBody.tradeInfo!.fssai,
        "tradeEmail": profileBody.tradeInfo!.tradeEmail,
        "trademobile": profileBody.tradeInfo!.tradeContactNumber,
        "pin": profileBody.tradeInfo!.pin,
        "state": profileBody.tradeInfo!.stateId,
        "district": profileBody.tradeInfo!.districtId,
        "address": profileBody.tradeInfo!.address,
        "tradeType": profileBody.tradeInfo!.tradeTypeCode,
        "location": profileBody.tradeInfo!.location,
        "userid": SharedStorage.getString(ApiConfig.userId)
      };
    }
    debugPrint("api call....");
    if (profileBody.userInfo != null) {
      userDataValue = {
        "firstname": profileBody.userInfo!.firstName,
        "lastname": profileBody.userInfo!.lastName,
        "email": profileBody.userInfo!.email,
        "mobile": profileBody.userInfo!.mobile,
        "gender": "",
        "DOB": "",
        "password": "",
        "userID": profileBody.userInfo!.userId
      };
    }
    //debugPrint(" file image is ${profileBody.userInfo!.profile!}");
    debugPrint(" checking 1${profileBody.tradeInfo?.tradeLogo}");
    Map<String, dynamic> params = {
      if (profileBody.userInfo != null)
        "userdatavalue": MultipartFile.fromString(jsonEncode(userDataValue)),
      if (profileBody.tradeInfo != null)
        "tradedatavalue": MultipartFile.fromString(jsonEncode(tradeDataValue)),
      if (profileBody.userInfo != null)
        "PROFILEIMAGE": profileBody.userInfo?.profile != null
            ? MultipartFile.fromFile(profileBody.userInfo!.profile!,
                filename: profileBody.userInfo!.profile!.split('/').last)
            : "",
      "userID": SharedStorage.getString(ApiConfig.userId),
      if (profileBody.tradeInfo != null)
        "TRADELOGO": profileBody.tradeInfo?.tradeLogo != null
            ? await MultipartFile.fromFile(profileBody.tradeInfo!.tradeLogo!,
                filename: profileBody.tradeInfo!.tradeLogo!.split('/').last)
            : "",
    };
    final formData = FormData.fromMap(params);
    final response = await client.postMethod(
        path: "${url}profileUpdate.php", params: formData);
    Body body = Body.fromJson(response["body"]);
    debugPrint("response:${response["body"]["status"]}");
    return body;
    // ProfileModel profileModel = ProfileModel.fromJson(response);
    // return profileModel;
  }

  @override
  Future<DistrictModel> districtList() async {
    final response = await client.getMethod(
      path: "${url}district.php",
    );
    DistrictModel districtModel = DistrictModel.fromJson(response);

    return districtModel;
  }

  @override
  Future<StateModel> stateList() async {
    final response = await client.getMethod(
      path: "${url}state.php",
    );
    StateModel stateModel = StateModel.fromJson(response);
    return stateModel;
  }
}
