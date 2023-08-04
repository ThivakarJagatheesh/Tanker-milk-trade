import 'package:dairy_products/data/models/apperror.dart';
import 'package:dairy_products/data/models/district.dart';
import 'package:dairy_products/domain/entity/no_params.dart';
import 'package:dairy_products/domain/repository/profile_trade_repo.dart';
import 'package:dairy_products/domain/use_case/use_case.dart';
import 'package:dartz/dartz.dart';

class DistrictUsecase extends UseCase<DistrictModel, NoParams> {
  final ProfileTradeRepository profileTradeRepository;
  DistrictUsecase(this.profileTradeRepository);
  @override
  Future<Either<AppError, DistrictModel>> call(NoParams params) async {
    return await profileTradeRepository.districtList();
  }
}
