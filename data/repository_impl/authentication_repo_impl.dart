
import 'package:dairy_products/data/models/apperror.dart';
import 'package:dairy_products/data/models/gender.dart';
import 'package:dairy_products/data/models/json_res_exception.dart';
import 'package:dairy_products/data/models/signup.dart';
import 'package:dairy_products/data/remote_data_source/authentication_data_source.dart';
import 'package:dairy_products/domain/repository/authentication.dart';
import 'package:dartz/dartz.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository{
  final AuthenticationDataSource authenticationDataSource;
  AuthenticationRepositoryImpl(this.authenticationDataSource);
  @override
  Future<Either<AppError, GenderModel>> getGenderList()async {
   try{
    final response = await authenticationDataSource.genderTanker();
    return Right(response);
   }
   on JsonResponseException catch (e){
    return Left(AppError(AppErrorType.api, e.body!.message!));
   }
  }

  @override
  Future<Either<AppError, dynamic>> postLogin(String email, String password) async{
    try{
    final response = await authenticationDataSource.loginTanker(email: email,password: password);
    return Right(response);
   }
   on JsonResponseException catch (e){
    return Left(AppError(AppErrorType.api, e.body!.message!));
   }
  }

  @override
  Future<Either<AppError, SignupModel>> postSignup(SignupModel signupModel) async{
    try{
    final response = await authenticationDataSource.signupTanker(signupModel);
    return Right(response);
   }
   on JsonResponseException catch (e){
    return Left(AppError(AppErrorType.api, e.body!.message!));
   }
  }
  
}