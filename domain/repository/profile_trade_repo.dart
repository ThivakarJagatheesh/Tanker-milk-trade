import 'package:dairy_products/data/models/apperror.dart';
import 'package:dairy_products/data/models/district.dart';
import 'package:dairy_products/data/models/json_res_exception.dart';
import 'package:dairy_products/data/models/profile_model.dart';
import 'package:dairy_products/data/models/state.dart';
import 'package:dairy_products/data/models/trade_nature_model.dart';
import 'package:dairy_products/data/models/trade_type_model.dart';
import 'package:dartz/dartz.dart';

abstract class ProfileTradeRepository{
  Future<Either<AppError,ProfileModel>> getProfileList(int? userId);
  Future<Either<AppError,TradeNatureModel>> getTradeNature(String? tradeCode);
  Future<Either<AppError,TradeTypeModel>> getTradeType(String? tradeTypeCode);
  Future<Either<AppError,dynamic>> addTradeAccount(ProfileBody profileBody);
  Future<Either<AppError,Body>>updateTradeAndProfile(ProfileBody profileBody);
   Future<Either<AppError,StateModel>> stateList();
  Future<Either<AppError,DistrictModel>> districtList();
}