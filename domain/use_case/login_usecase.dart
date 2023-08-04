
import 'package:dairy_products/data/models/apperror.dart';
import 'package:dairy_products/domain/entity/login_params.dart';
import 'package:dairy_products/domain/repository/authentication.dart';
import 'package:dairy_products/domain/use_case/use_case.dart';
import 'package:dartz/dartz.dart';

class LoginUsecase extends UseCase<dynamic,LoginParams>{
  final AuthenticationRepository authenticationRepository;
  LoginUsecase(this.authenticationRepository);

  @override
  Future<Either<AppError, dynamic>> call(LoginParams params) async{
  return await authenticationRepository.postLogin(params.email, params.password);
  }
  
}