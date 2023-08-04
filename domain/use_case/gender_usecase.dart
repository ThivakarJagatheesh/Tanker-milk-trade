import 'package:dairy_products/data/models/apperror.dart';
import 'package:dairy_products/domain/entity/no_params.dart';
import 'package:dairy_products/domain/repository/authentication.dart';
import 'package:dairy_products/domain/use_case/use_case.dart';
import 'package:dartz/dartz.dart';

class GenderUsecase extends UseCase<dynamic, NoParams> {
  final AuthenticationRepository authenticationRepository;
  GenderUsecase(this.authenticationRepository);

  @override
  Future<Either<AppError, dynamic>> call(NoParams params) async {
    return await authenticationRepository.getGenderList();
  }
}
