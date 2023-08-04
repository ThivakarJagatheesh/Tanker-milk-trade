

import 'package:dairy_products/data/models/apperror.dart';
import 'package:dairy_products/data/models/gender.dart';
import 'package:dairy_products/data/models/signup.dart';
import 'package:dartz/dartz.dart';

abstract class AuthenticationRepository{
  Future<Either<AppError,GenderModel>> getGenderList();
  Future<Either<AppError,SignupModel>> postSignup(SignupModel signupModel);
  Future<Either<AppError,dynamic>>postLogin(String email, String password);
}