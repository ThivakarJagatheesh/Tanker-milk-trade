import 'package:dairy_products/data/models/apperror.dart';
import 'package:dairy_products/data/models/post_buy_shell_model.dart';
import 'package:dairy_products/data/models/product_model.dart';
import 'package:dartz/dartz.dart';

abstract class ProductRepository{
  Future<Either<AppError,dynamic>> addProduct(ShellBuyBody postBuyShell);
  Future<Either<AppError,ShellBuyModel>> getProductHistoryBuyShell(int? userId);
  Future<Either<AppError,ShellBuyModel>> getProductList();
  Future<Either<AppError,ProductModel>>getProductType(int? productId);
  Future<Either<AppError,ProductModel>>getSubProductType(int? productId);
}