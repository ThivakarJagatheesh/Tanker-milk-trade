import 'package:dairy_products/data/models/district.dart';
import 'package:dairy_products/data/models/json_res_exception.dart';
import 'package:dairy_products/data/models/state.dart';
import 'package:dairy_products/data/models/trade_type_model.dart';
import 'package:dairy_products/data/models/trade_nature_model.dart';
import 'package:dairy_products/data/models/profile_model.dart';
import 'package:dairy_products/data/models/apperror.dart';
import 'package:dairy_products/data/remote_data_source/profile_trade_data_source.dart';
import 'package:dairy_products/domain/repository/profile_trade_repo.dart';
import 'package:dartz/dartz.dart';

class ProfileTradeRepoImpl extends ProfileTradeRepository {
  final ProfileTradeDataSource profileTradeDataSource;
  ProfileTradeRepoImpl(this.profileTradeDataSource);
  @override
  Future<Either<AppError, dynamic>> addTradeAccount(
      ProfileBody profileBody) async {
    try {
      final response =
          
          await profileTradeDataSource.addTradeAccount(profileBody);
      
      
      
      return Right(response);
    } on JsonResponseException catch (e) {
      return Left(AppError(AppErrorType.api, e.body!.message!));
    }
  }

  @override
  Future<Either<AppError, ProfileModel>> getProfileList(int? userId) async {
    try {
      final response = await profileTradeDataSource.getProfileList(userId);
      return Right(response);
    } on JsonResponseException catch (e) {
      return Left(AppError(AppErrorType.api, e.body!.message!));
    }
  }

  @override
  Future<Either<AppError, TradeNatureModel>> getTradeNature(
      String? tradeCode) async {
    try {
      final response = await profileTradeDataSource.getTradeNature(tradeCode);
      return Right(response);
    } on JsonResponseException catch (e) {
      return Left(AppError(AppErrorType.api, e.body!.message!));
    }
  }

  @override
  Future<Either<AppError, TradeTypeModel>> getTradeType(
      String? tradeTypeCode) async {
    try {
      final response = await profileTradeDataSource.getTradeType(tradeTypeCode);
      return Right(response);
    } on JsonResponseException catch (e) {
      return Left(AppError(AppErrorType.api, e.body!.message!));
    }
  }

  @override
  Future<Either<AppError, Body>> updateTradeAndProfile(
      ProfileBody profileBody) async {
    try {
      final response =
          await profileTradeDataSource.updateTradeAndProfile(profileBody);
      return Right(response);
    } on JsonResponseException catch (e) {
      return Left(AppError(AppErrorType.api, e.body!.message!));
    }
  }
  
  @override
  Future<Either<AppError, DistrictModel>> districtList() async{
   try {
      final response =
          await profileTradeDataSource.districtList();
      return Right(response);
    } on JsonResponseException catch (e) {
      return Left(AppError(AppErrorType.api, e.body!.message!));
    }
  }
  
  @override
  Future<Either<AppError, StateModel>> stateList() async{
    try {
      final response =
          await profileTradeDataSource.stateList();
      return Right(response);
    } on JsonResponseException catch (e) {
      return Left(AppError(AppErrorType.api, e.body!.message!));
    }
  }
}
