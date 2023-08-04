import 'package:dairy_products/data/models/json_res_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiClient {
  final Dio dio;

  ApiClient(this.dio);

  dynamic postMethod(
      {String? path, dynamic params, Map<String, dynamic>? params1}) async {
    //   dio.options.baseUrl = ApiConfig.baseUrl;
    // dio.options.connectTimeout = const Duration(seconds: 5).inSeconds;
    // dio.options.receiveTimeout = const Duration(seconds: 3).inSeconds;
    var headers = {
      "Content-Type": "multipart/form-data",
      'Accept': 'application/json',
    };
    Response response = await dio.postUri(Uri.parse(path!),
        data: params,
        options: Options(
            responseType: ResponseType.json, headers: params1 ?? headers)
        //queryParameters: params,
        //options: Options(headers: params1, method: "POST",),
        );
    response.headers['set-cookie'];
      debugPrint("response ${response.data}");
    if (response.statusCode == 200) {
      return response.data;
    } else {
      JsonResponseException jsonResponseException =
          JsonResponseException.fromJson(response.data);
      throw jsonResponseException;
    }
  }

  dynamic getMethod({
    String? path,
    Map<String, dynamic>? params,
  }) async {
    var headers = {
      "Content-Type": "multipart/form-data",
      'Accept': 'application/json',
    };
    final response = await dio.get(path!,
        queryParameters: params,
        options: Options(responseType: ResponseType.json, headers: headers));
    if (response.statusCode == 200) {
      return response.data;
    } else {
      JsonResponseException jsonResponseException =
          JsonResponseException.fromJson(response.data);
      throw jsonResponseException;
    }
  }
}
