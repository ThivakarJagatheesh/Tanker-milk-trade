import 'package:dairy_products/data/models/json_res_exception.dart';
import 'package:dairy_products/data/models/product_model.dart';
import 'package:dairy_products/data/models/post_buy_shell_model.dart';
import 'package:dairy_products/data/models/apperror.dart';
import 'package:dairy_products/data/remote_data_source/product_data_source.dart';
import 'package:dairy_products/domain/repository/product_repo.dart';
import 'package:dartz/dartz.dart';

class ProductRepoImpl extends ProductRepository{
    final ProductDataSource productDataSource;
  ProductRepoImpl(this.productDataSource);
  @override
  Future<Either<AppError, dynamic>> addProduct(ShellBuyBody postBuyShell) async{
   try{
    final response = await productDataSource.addProduct(postBuyShell);
    return Right(response);
   }
   on JsonResponseException catch (e){
    return Left(AppError(AppErrorType.api, e.body!.message!));
   }
  }

  @override
  Future<Either<AppError, ShellBuyModel>> getProductHistoryBuyShell(int? userId) async{
     try{
    final response = await productDataSource.getProductHistoryBuyShell(userId!);
    return Right(response);
   }
   on JsonResponseException catch (e){
    return Left(AppError(AppErrorType.api, e.body!.message!));
   }
  }

  @override
  Future<Either<AppError, ShellBuyModel>> getProductList() async{
      try{
    final response = await productDataSource.getProductList();
    return Right(response);
   }
   on JsonResponseException catch (e){
    return Left(AppError(AppErrorType.api, e.body!.message!));
   }
  }

  @override
  Future<Either<AppError, ProductModel>> getProductType(int? productId) async{
     try{
    final response = await productDataSource.getProductType(productId);
    return Right(response);
   }
   on JsonResponseException catch (e){
    return Left(AppError(AppErrorType.api, e.body!.message!));
   }
  }

  @override
  Future<Either<AppError, ProductModel>> getSubProductType(int? productId) async{
    try{
    final response = await productDataSource.getSubProductType(productId);
    return Right(response);
   }
   on JsonResponseException catch (e){
    return Left(AppError(AppErrorType.api, e.body!.message!));
   }
  }
}