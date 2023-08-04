
import 'package:dairy_products/data/models/apperror.dart';
import 'package:dairy_products/data/models/signup.dart';
import 'package:dairy_products/domain/repository/authentication.dart';
import 'package:dairy_products/domain/use_case/use_case.dart';
import 'package:dartz/dartz.dart';



class SignUpUsecase extends UseCase<dynamic, SignupModel> {
  final AuthenticationRepository authenticationRepository;
  SignUpUsecase(this.authenticationRepository);

  @override
  Future<Either<AppError, dynamic>> call(SignupModel params) async {
    return await authenticationRepository.postSignup(params);
  }
}
