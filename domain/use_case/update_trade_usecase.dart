import 'package:dairy_products/data/models/apperror.dart';
import 'package:dairy_products/data/models/json_res_exception.dart';
import 'package:dairy_products/data/models/profile_model.dart';
import 'package:dairy_products/domain/repository/profile_trade_repo.dart';
import 'package:dairy_products/domain/use_case/use_case.dart';
import 'package:dartz/dartz.dart';

class UpdateTradeAccountUsecase extends UseCase<Body, ProfileBody> {
  final ProfileTradeRepository profileTradeRepository;
  UpdateTradeAccountUsecase(this.profileTradeRepository);

  @override
  Future<Either<AppError, Body>> call( params) async {
    return await profileTradeRepository.updateTradeAndProfile(params);
  }
}
