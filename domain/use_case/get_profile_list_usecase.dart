import 'package:dairy_products/data/models/apperror.dart';
import 'package:dairy_products/domain/repository/profile_trade_repo.dart';
import 'package:dairy_products/domain/use_case/use_case.dart';
import 'package:dartz/dartz.dart';

class GetProfileListUsecase extends UseCase<dynamic, int?> {
  final ProfileTradeRepository profileTradeRepository;
  GetProfileListUsecase(this.profileTradeRepository);

  @override
  Future<Either<AppError, dynamic>> call(params) async {
    return await profileTradeRepository.getProfileList(params);
  }
}
