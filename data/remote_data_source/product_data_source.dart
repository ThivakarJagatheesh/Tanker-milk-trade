import 'dart:convert';

import 'package:dairy_products/data/api_client/api_client.dart';
import 'package:dairy_products/data/api_config/api_config.dart';
import 'package:dairy_products/data/models/post_buy_shell_model.dart';
import 'package:dairy_products/data/models/product_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class ProductDataSource {
  Future<dynamic> addProduct(ShellBuyBody postBuyShell);
  Future<ShellBuyModel> getProductHistoryBuyShell(int? userId);
  Future<ShellBuyModel> getProductList();
  Future<ProductModel> getProductType(int? productId);
  Future<ProductModel> getSubProductType(int? productId);
}

String url = ApiConfig.baseUrl;

class ProductDataSourceImpl extends ProductDataSource {
  final ApiClient client;
  ProductDataSourceImpl(this.client);
  @override
  Future addProduct(ShellBuyBody postBuyShell) async {
    var datavalue = {
      "productType": postBuyShell.productType,
      "milktype": postBuyShell.milkType,
      "avaiablequanitity": postBuyShell.avaiablequanitity,
      "FAT": postBuyShell.fat,
      "MBRT": postBuyShell.mbrt,
      "ageOfMilk": postBuyShell.ageOfMilk,
      "SNF": postBuyShell.snf,
      "labreportFile": postBuyShell.prductImage,
      "productName": postBuyShell.productName,
      "prductImage": postBuyShell.labreportFile,
      "price": postBuyShell.price,
      "postType": postBuyShell.postType,
      "userID": postBuyShell.userId,
      "postCreatedDateTime":
          postBuyShell.postCreatedDateTime!.toLocal().toString(),
      "postExpiredDateTime":
          postBuyShell.postExpiredDateTime!.toLocal().toString()
    };

    Map<String, dynamic> params = {
      "datavalue": MultipartFile.fromString(jsonEncode(datavalue)),
      "ProductImage":postBuyShell.prductImage!=null? await MultipartFile.fromFile(postBuyShell.prductImage!,
          filename: postBuyShell.prductImage!.split('/').last):"",
      "ProductLabReport":  postBuyShell.labreportFile!=null?await MultipartFile.fromFile(
        postBuyShell.labreportFile!,
        filename: postBuyShell.labreportFile!.split('/').last,
      ):""
    };
    final formData = FormData.fromMap(params);
    final response = await client.postMethod(
        path: "${url}postCreation.php", params: formData);
    debugPrint("response:${response["body"]["status"]}");
    // ShellBuyModel shellBuyModel = ShellBuyModel.fromJson(response);
    // return shellBuyModel;
  }

  @override
  Future<ShellBuyModel> getProductHistoryBuyShell(int? userId) async {
    Map<String, dynamic> params = {
      "userID": userId,
    };
    final formData = FormData.fromMap(params);
    final response = await client.postMethod(
        path: "${url}postHistory.php", params: formData);
    ShellBuyModel postShellBuyModel = ShellBuyModel.fromJson(response);
    return postShellBuyModel;
  }

  @override
  Future<ShellBuyModel> getProductList() async {
    final response = await client.getMethod(
      path: "${url}postlisting.php",
    );
    ShellBuyModel postShellBuyModel = ShellBuyModel.fromJson(response);
    return postShellBuyModel;
  }

  @override
  Future<ProductModel> getProductType(int? productId) async {
    // Map<String, dynamic> params = {
    //   "productTypeID": (productId),
    // };
    // final formData = FormData.fromMap(params);
    final response =
        await client.getMethod(path: "${url}productType.php", params: {});
    ProductModel productModel = ProductModel.fromJson(response);
    return productModel;
  }

  @override
  Future<ProductModel> getSubProductType(int? productId) async {
    Map<String, dynamic> params = {
      "productTypeID": productId,
    };
    final response = await client.getMethod(
        path: "${url}subProductType.php", params: params);
    ProductModel productModel = ProductModel.fromJson(response);
    return productModel;
  }
}
